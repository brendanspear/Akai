//
//  SamplerType.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2024-05-21.
//

import Foundation

enum SamplerType: String, CaseIterable, Identifiable, Codable {
    case s900 = "S900"
    case s950 = "S950"
    case s1000 = "S1000/S1100"
    case s3000 = "S3000/S3200"

    var id: String { rawValue }
}
