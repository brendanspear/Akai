//
//  LoadedSample.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/12/25.
//
import Foundation

struct LoadedSample {
    let data: [Int16]
    let sampleRate: UInt32
    let channels: Int
    let bitDepth: UInt8
    let filename: String
    var duration: Double 
}

