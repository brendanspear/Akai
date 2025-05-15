//
//  OutputPathHelper.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct OutputPathHelper {
    
    /// Generates an output file path in the same directory with a new extension.
    static func generateOutputPath(for inputPath: String, newExtension: String) -> String {
        let url = URL(fileURLWithPath: inputPath)
        let directory = url.deletingLastPathComponent()
        let fileName = url.deletingPathExtension().lastPathComponent
        let outputURL = directory.appendingPathComponent(fileName).appendingPathExtension(newExtension)
        return outputURL.path
    }
    
    /// Generates an output path inside a specific directory.
    static func generateOutputPath(in directory: URL, forOriginalFile original: String, newExtension: String) -> String {
        let originalURL = URL(fileURLWithPath: original)
        let baseName = originalURL.deletingPathExtension().lastPathComponent
        let outputURL = directory.appendingPathComponent(baseName).appendingPathExtension(newExtension)
        return outputURL.path
    }
    
    /// Ensures the output directory exists, creating it if needed.
    static func ensureOutputDirectoryExists(_ directory: URL) throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directory.path) {
            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        }
    }
}

