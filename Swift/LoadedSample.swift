//
//  LoadedSample.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/12/25.
//  Licensed under GNU General Public License v3.0
//

import Foundation

struct LoadedSample {
    var data: [Int16]
    var sampleRate: UInt32
    var channels: Int
    var bitDepth: UInt8
    let filename: String

    var duration: Double {
        return Double(data.count) / Double(sampleRate)
    }
}
