//
//  SampleFormat.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2024-05-21.
//

import Foundation

enum SampleFormat: String, Codable, CaseIterable {
    case pcm12 = "PCM 12-bit"
    case pcm16 = "PCM 16-bit"
    case wav = "WAV" // Added to resolve missing member error
}
