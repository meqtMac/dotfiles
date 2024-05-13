import SystemPackage

let resourcesPath = FilePath(#filePath)
    .removingLastComponent()
    .removingLastComponent()
    .appending("Resources/")

// MARK: create symbolic links
let zshrcAlias = "my_zshrc"
let dotfiles = [zshrcAlias, "vim", "gitconfig", "gitignore_global", "vimrc"]
let targets = dotfiles.map {
    resourcesPath.appending($0)
}
let links = dotfiles.map {
    homePath.appending("." + $0)
}
for (target, link) in zip(targets, links) {
    do {
        try createLink(link, to: target)
    } catch {
        logger.error("\(error)")
    }
}

let zshrcTemplatePath = resourcesPath.appending("zshrc_template.sh")

// MARK: edit ~/.zshrc
let zshrcPath = homePath.appending(".zshrc")
if let zshrcContents = try? zshrcPath.content() {
    
    let template = try! zshrcTemplatePath.content()
    
    if zshrcContents.contains(template) {
        logger.warning(".zshrc already sources .my_zshrc")
    } else {
        try template.write(to: zshrcPath)
        logger.info("Added source of template to .zshrc")
   }
}

// MARK: icloud
#if os(macOS)
let icloudLinkPath = homePath.appending("icloud")
let icloudDstPath = homePath.appending("Library/Mobile Documents/com~apple~CloudDocs/")
do {
    try createLink(icloudLinkPath, to: icloudDstPath)
} catch {
    logger.error("\(error)")
}
#endif
