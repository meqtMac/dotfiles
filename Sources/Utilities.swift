//
//  File.swift
//  
//
//  Created by 蒋艺 on 2024/1/10.
//

import Foundation

func createLinkAndLog(for target: URL, linkName: URL) {
    do {
        try fileManager.createSymbolicLink(at: linkName, withDestinationURL: target)
        logger.info("Created \(linkName)")
    } catch {
        logger.error("\(error.localizedDescription)")
    }
}



//#if !DEBUG
struct Logger {
    func info(_ message: some StringProtocol) {
        print("✅" + message.dated())
    }
    
    func warning(_ message: some StringProtocol) {
        print("⚠️" + message.dated())
    }
    
    func error(_ message: some StringProtocol) {
        print("❌" + message.dated())
    }
    
    func debug(_ message: some StringProtocol) {
        #if DEBUG
        info(message)
        #endif
    }
    
//    static func getLineWidth() throws -> Int {
//        let process = Process()
//        process.executableURL = URL(filePath: "/usr/bin/tput")
//        process.arguments = ["cols"]
//        let pipe = Pipe()
//        process.standardOutput = pipe
//        try process.run()
//        process.waitUntilExit()
//        guard let data = try pipe.fileHandleForReading.readToEnd() else {
//            throw LoggerError.lineWithError
//        }
//        guard let str = String(data: data, encoding: .utf8) else {
//            throw LoggerError.lineWithError
//        }
//        guard let width = Int(str) else {
//            throw LoggerError.lineWithError
//        }
//        return width
//    }
//    enum LoggerError: Error {
//        case lineWithError
//    }
    
   
}

// TODO: put time to the end of the file
fileprivate extension StringProtocol {
    func dated() -> some StringProtocol  {
        #if os(Linux)
        let dateString = Date().debugDescription
        #else
        let dateString = "\(Date().formatted(date: .omitted, time: .standard))"
        #endif

        
        let message = "\(self)"
       return message + dateString
    }
}
//#endif
