//
//  AudioMetadata.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-18.
//

import Foundation

/// Represents basic metadata extracted from an audio file.
struct AudioMetadata: Identifiable, Equatable {
    let id = UUID()
    let duration: Double
    let sampleRate: Double
    let channels: Int
}
