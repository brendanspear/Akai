//
//  FileConversionTask.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct FileConversionTask: Identifiable, Hashable {
    let id = UUID()
    let inputPath: String
    var outputPath: String?
    var status: ConversionStatus = .pending
    var errorMessage: String?

    enum ConversionStatus: String {
        case pending
        case processing
        case completed
        case failed
    }

    var filename: String {
        return URL(fileURLWithPath: inputPath).lastPathComponent
    }

    var outputFilename: String? {
        if let outputPath = outputPath {
            return URL(fileURLWithPath: outputPath).lastPathComponent
        }
        return nil
    }
}

