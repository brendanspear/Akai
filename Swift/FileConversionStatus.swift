
// FileConversionStatus.swift
// AkaiSConvert
// Created by Brendan Spear on 2025-05-XX.

import Foundation

enum FileConversionStatus: String, Codable {
    case pending
    case processing
    case completed
    case failed
}
