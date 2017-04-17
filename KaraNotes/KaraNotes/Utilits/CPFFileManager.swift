//
//  CPFFileManager.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/17.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFFileManager: NSObject {

    static let instance:CPFFileManager = CPFFileManager()
    
    fileprivate let fileManager = FileManager.default
    
    static func shareInstance() -> CPFFileManager {
        return instance
    }
}


// MARK: - API
extension CPFFileManager {
    
    func createLocalWorkspace() -> String {
        let localWorkspace = self.localWorkspace()
        if !self.fileManager.fileExists(atPath: localWorkspace) {
            try? self.fileManager.createDirectory(atPath: localWorkspace, withIntermediateDirectories: true, attributes: nil)
        }
        return localWorkspace
    }
    
    func createFolder(folderPath: String) -> String {
        if !fileManager.fileExists(atPath: folderPath) {
            try? fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            return folderPath
        }
        return ""
    }
    
    func createFile(filePath: String, withContent content: Data) -> String {
        if !fileManager.fileExists(atPath: filePath) {
            fileManager.createFile(atPath: filePath, contents: content, attributes: nil)
            return filePath
        }
        return ""
    }
    
    func saveFileToPath(filePath: String, withContent content: NSData) -> Bool {
        if fileManager.fileExists(atPath: filePath) { return false }
        guard content.write(to: URL(fileURLWithPath: filePath), atomically: true) else { return false }
        return true
    }
    
    func deleteFile(filePath: String) -> Bool {
        if !fileManager.fileExists(atPath: filePath) { return false }
        
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error {
            print("deleteFileError:\(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func moveFile(filePath: String, toNewPath newPath: String) -> Bool {
        if !fileManager.fileExists(atPath: filePath) { return false }
        if fileManager.fileExists(atPath: newPath) { return false }
        
        do {
            try fileManager.moveItem(atPath: filePath, toPath: newPath)
        } catch let error {
            print("moveFileError:\(error.localizedDescription)")
            return false
        }
        return true
    }
}


// MARK: - private API
extension CPFFileManager {
    fileprivate func localWorkspace() -> String {
        return (documentPath() as NSString).appendingPathComponent("KaraNotes")
    }
    
    fileprivate func documentPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
}
