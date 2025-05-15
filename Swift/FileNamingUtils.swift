//
//  FileNamingUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct FileNamingUtils {
    
    static func generateOutputFilename(inputPath: String, suffix: String, newExtension: String) -> String {
        let url = URL(fileURLWithPath: inputPath)
        let baseName = url.deletingPathExtension().lastPathComponent
        let directory = url.deletingLastPathComponent().path
        let outputName = "\(baseName)_\(suffix).\(newExtension)"
        return (directory as NSString).appendingPathComponent(outputName)
    }

    static func generatePreviewFilename(forOriginalPath original: String) -> String {
        return generateOutputFilename(inputPath: original, suffix: "preview", newExtension: "wav")
    }

    static func generateConvertedFilename(forOriginalPath original: String, targetFormat: String) -> String {
        return generateOutputFilename(inputPath: original, suffix: "converted", newExtension: targetFormat)
    }

    static func defaultExportFolder() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first?.path ?? NSTemporaryDirectory()
    }

    static func ensureFolderExists(path: String) {
        let fm = FileManager.default
        if !fm.fileExists(atPath: path) {
            try? fm.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}

