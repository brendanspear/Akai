//
//  SamplerOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

enum SamplerType: String, CaseIterable {
    case s900 = "Akai S900"
    case s1000 = "Akai S1000"
    case s3000 = "Akai S3000"
}

enum OutputFormat: String, CaseIterable {
    case floppydisk = "Floppy Disk (720KB)"
    case zuluSCSI = "ZuluSCSI (1GB)"
    case gotek = "Gotek (720KB)"
    case customSize = "Custom"
}


