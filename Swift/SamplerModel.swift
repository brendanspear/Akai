//
//  SamplerModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

enum SamplerModel: String, CaseIterable, Identifiable {
    case s900 = "Akai S900"
    case s1000 = "Akai S1000"
    case s3000 = "Akai S3000"

    var id: String { rawValue }

    var maxSampleRate: Int {
        switch self {
        case .s900:
            return 40000
        case .s1000, .s3000:
            return 48000
        }
    }

    var bitDepth: Int {
        switch self {
        case .s900:
            return 12
        case .s1000, .s3000:
            return 16
        }
    }

    var supportsStereo: Bool {
        switch self {
        case .s900:
            return false
        case .s1000, .s3000:
            return true
        }
    }

    var fileExtension: String {
        switch self {
        case .s900:
            return "S9K"
        case .s1000:
            return "S1K"
        case .s3000:
            return "S3K"
        }
    }
}

