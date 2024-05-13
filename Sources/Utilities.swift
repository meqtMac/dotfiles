//
//  File.swift
//  
//
//  Created by 蒋艺 on 2024/1/10.
//

import Logging
let logger = Logger(label: "meqtmac.dotfile")

#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif
import SystemPackage

enum DotFileError: Error {
    case symlinkError(Errno)
}

let homePath: FilePath = {
    let env = getenv("HOME")
    let str = String(cString: env!) + "/"
    let path = FilePath(str)
    return path
}()


func createLink(_ link: FilePath, to linkDst: FilePath) throws {
    let res = symlink(linkDst.string, link.string)
    if res != 0 {
        let error = Errno(rawValue: errno)
        throw DotFileError.symlinkError(error)
    }
}


extension FilePath {
    func content() throws -> String {
        let fd = try FileDescriptor.open(self, .readOnly)
        return try fd.closeAfter {
            let bytes = try fd.seek(offset: 0, from: .end)
            try fd.seek(offset: 0, from: .start)
            return try String(unsafeUninitializedCapacity: Int(bytes) + 1 ) { buffer in
                let rawBuffer = UnsafeMutableRawBufferPointer(buffer)
                let count = try fd.read(into: rawBuffer)
//                return try fd.read(into: rawBuffer)
                return count
            }
        }
    }
}

extension String {
    func write(to path: FilePath) throws {
        let fd = try FileDescriptor.open(path, .writeOnly)
        try fd.closeAfter {
            _ = try fd.writeAll(self.utf8)
        }
    }
}

