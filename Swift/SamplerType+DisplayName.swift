
//
//  SamplerType+DisplayName.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-22.
//

import Foundation

extension SamplerType {
    var displayName: String {
        switch self {
        case .s900: return "S900"
        case .s950: return "S950"
        case .s1000: return "S1000/S1100"
        case .s3000: return "S3000/S3200"
        }
    }
}
