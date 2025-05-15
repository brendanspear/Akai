//
//  SamplerOutputOption.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SamplerOutputOption: Identifiable {
    let id = UUID()
    let label: String
    let description: String
    let diskSizeLimitBytes: Int?
    
    static let floppy = SamplerOutputOption(
        label: "Floppy (1.44MB)",
        description: "Fits on a 1.44MB floppy disk.",
        diskSizeLimitBytes: 1_474_560
    )
    
    static let zuluSCSI = SamplerOutputOption(
        label: "ZuluSCSI SD",
        description: "Format for ZuluSCSI SD card partitions.",
        diskSizeLimitBytes: 524_288_000 // 500MB for example
    )
    
    static let gotek = SamplerOutputOption(
        label: "Gotek Image",
        description: "Generate files for Gotek flash drives.",
        diskSizeLimitBytes: 1_474_560
    )
    
    static let unlimited = SamplerOutputOption(
        label: "Unlimited",
        description: "No file size limit applied.",
        diskSizeLimitBytes: nil
    )
    
    static let allOptions: [SamplerOutputOption] = [
        .floppy,
        .zuluSCSI,
        .gotek,
        .unlimited
    ]
}

