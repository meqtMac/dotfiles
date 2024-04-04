import Foundation

// MARK: Configuration
#if DEBUG
//import OSLog
let logger = Logger()
#else
let logger = Logger()
#endif

#if os(Linux)
public extension URL {
    func appending(path: String) -> URL {
        appendingPathComponent(path)
    }
    init(filePath: String) {
        self = Self.init(fileURLWithPath: filePath)
    }
}
#endif
 

let fileManager = FileManager.default
let homeDirectory = fileManager.homeDirectoryForCurrentUser

let resourceDirectory = {
   var url = URL(filePath: #file)
    while url.lastPathComponent != "Sources" {
        url.deleteLastPathComponent()
    }
    url.deleteLastPathComponent()
   return url.appending(path: "Resources")
}()

// MARK: create symbolic links
let zshrcAlias = "my_zshrc"
let dotfiles = [zshrcAlias, "vim", "gitconfig", "gitignore_global", "vimrc"]
let targets = dotfiles.map { resourceDirectory.appending(path: $0) }
let links = dotfiles.map { homeDirectory.appending(path: "." + $0) }
for (target, link) in zip(targets, links) {
    createLinkAndLog(for: target, linkName: link)
}

// MARK: edit ~/.zshrc
let zshrcDirectory = homeDirectory.appending(path: ".zshrc")
if let zshrcContents = try? String(contentsOf: zshrcDirectory) {
    let template = {
        let string = try? String(contentsOf: resourceDirectory.appending(path: "zshrc_template.sh"))
        return (string ?? "").replacingOccurrences(of: "FILE", with: zshrcAlias)
    }()
    if zshrcContents.contains(template) {
        logger.warning(".zshrc already sources .my_zshrc")
    } else {
        do {
            try template.write(to: zshrcDirectory, atomically: true, encoding: .utf8)
            logger.info("Added source of template to .zshrc")
        } catch {
            logger.error(error.localizedDescription)
        }
    }
}

// MARK: icloud
#if os(macOS)
let icloudLink = homeDirectory.appending(path: "icloud")
let icloudDirectory = homeDirectory.appending(path: "Library/Mobile Documents/com~apple~CloudDocs")
createLinkAndLog(for: icloudDirectory, linkName: icloudLink)
#else
logger.error("This script only works on macOS.")
#endif
