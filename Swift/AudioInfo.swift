//
//  AudioInfo.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation
import AVFoundation

struct AudioFileInfo {
    let url: URL
    let sampleRate: Float64
    let bitDepth: UInt32
    let channels: UInt32
    let duration: TimeInterval
}

class AudioInfo {
    
    static func extractInfo(from url: URL) -> AudioFileInfo? {
        let asset = AVURLAsset(url: url)
        guard let formatDesc = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first,
              let streamDesc = CMAudioFormatDescriptionGetStreamBasicDescription(formatDesc as! CMAudioFormatDescription) else {
            return nil
        }
        
        let sampleRate = streamDesc.pointee.mSampleRate
        let channels = streamDesc.pointee.mChannelsPerFrame
        let bitDepth = streamDesc.pointee.mBitsPerChannel
        let duration = CMTimeGetSeconds(asset.duration)

        return AudioFileInfo(url: url,
                             sampleRate: sampleRate,
                             bitDepth: UInt32(bitDepth),
                             channels: UInt32(channels),
                             duration: duration)
    }
}
