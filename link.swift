#!swift
import Foundation

let dotfilesDir = FileManager.default.currentDirectoryPath
let dotfiles: [String] = ["zshrc", "vim", "gitconfig", "gitignore_global", "vimrc"]
let targets = dotfiles.map { dotfilesDir + "/" + $0 }
let links: [String] = dotfiles.map { dotfile in
    if dotfile == "zshrc" { return NSHomeDirectory() + "/.my_zshrc" }
    return NSHomeDirectory() + "/." + dotfile
}

// create link
func createLink(target: String, linkName: String) {
    if FileManager.default.fileExists(atPath: linkName) {
        print("Error: \(linkName) already exists.")
//        return
    }
    if !FileManager.default.fileExists(atPath: target) {
        print("Error: \(target) doesn't exists.")
//        return
    }
    do {
        try FileManager.default.createSymbolicLink(atPath: linkName, withDestinationPath: target)
        print("Created \(linkName)")
    } catch {
        print("Error creating link: \(error.localizedDescription)")
    }
}

for (target, link) in zip(targets, links) {
    createLink(target: target, linkName: link)
}

// Append code to .zshrc to source ~/.my_zshrc if it doesn't already
if let zshrcContents = try? String(contentsOfFile: NSHomeDirectory() + "/.zshrc") {
    let zshrcAppend = """
        if [[ -e ~/.my_zshrc ]]; then
            source ~/.my_zshrc
        else
            echo "Error: ~/.my_zshrc file or link does not exist."
        fi
        """
    if zshrcContents.contains(zshrcAppend) {
        print(".zshrc already sources .my_zshrc")
//        return
    }
    do {
        try zshrcAppend.write(toFile: NSHomeDirectory() + "/.zshrc", atomically: true, encoding: .utf8)
        print("Added sourcing of .my_zshrc to .zshrc")
    }catch{
        print("Error creating link: \(error.localizedDescription)")
    }
}

#if os(macOS)
// Check if the "icloud" link already exists
let iCloudURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("icloud")
if !FileManager.default.fileExists(atPath: iCloudURL.path) {
    // Create the "iCloud" link to the iCloud Drive folder
    let icloudDriveURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Mobile Documents/com~apple~CloudDocs")
    do {
        try FileManager.default.createSymbolicLink(atPath: iCloudURL.path, withDestinationPath: icloudDriveURL.path)
        print("Created iCloud link.")
    } catch {
        print("Error creating iCloud link: \(error)")
    }
} else {
    print("iCloud link already exists.")
}
#else
print("This script only works on macOS.")
#endif
