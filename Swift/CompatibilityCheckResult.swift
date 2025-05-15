//
//  CompatibilityCheckResult.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/12/25.
//
import Foundation

struct CompatibilityCheckResult {
    let filename: String
    let isCompatible: Bool
    let issues: [String]
}

