//
//  ProcessingStatus.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct ProcessingStatus {
    var fileName: String
    var success: Bool
    var message: String
    var warnings: [String]

    init(fileName: String, success: Bool = true, message: String = "", warnings: [String] = []) {
        self.fileName = fileName
        self.success = success
        self.message = message
        self.warnings = warnings
    }
}

