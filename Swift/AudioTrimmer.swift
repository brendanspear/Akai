//
//  AudioTrimmer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

class AudioTrimmer {
    
    static func trimSilence(from buffer: AVAudioPCMBuffer, threshold: Float = 0.01) -> AVAudioPCMBuffer? {
        guard let floatChannelData = buffer.floatChannelData else { return nil }
        let frameLength = Int(buffer.frameLength)
        let channelCount = Int(buffer.format.channelCount)
        
        var startFrame = 0
        var endFrame = frameLength - 1

        // Detect first sample above threshold
        outerStart: for i in 0..<frameLength {
            for ch in 0..<channelCount {
                if abs(floatChannelData[ch][i]) > threshold {
                    startFrame = i
                    break outerStart
                }
            }
        }

        // Detect last sample above threshold
        outerEnd: for i in stride(from: frameLength - 1, through: 0, by: -1) {
            for ch in 0..<channelCount {
                if abs(floatChannelData[ch][i]) > threshold {
                    endFrame = i
                    break outerEnd
                }
            }
        }

        let trimmedLength = endFrame - startFrame + 1
        guard trimmedLength > 0 else { return nil }

        let format = buffer.format
        guard let trimmedBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(trimmedLength)) else {
            return nil
        }
        
        trimmedBuffer.frameLength = AVAudioFrameCount(trimmedLength)
        
        for ch in 0..<channelCount {
            memcpy(trimmedBuffer.floatChannelData![ch],
                   floatChannelData[ch] + startFrame,
                   trimmedLength * MemoryLayout<Float>.size)
        }
        
        return trimmedBuffer
    }
    
    static func addSilence(to buffer: AVAudioPCMBuffer, milliseconds: Int, sampleRate: Double) -> AVAudioPCMBuffer? {
        let silenceFrames = AVAudioFrameCount((Double(milliseconds) / 1000.0) * sampleRate)
        let newFrameLength = buffer.frameLength + silenceFrames
        let format = buffer.format
        
        guard let newBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: newFrameLength) else {
            return nil
        }

        newBuffer.frameLength = newFrameLength
        let channelCount = Int(format.channelCount)
        
        for ch in 0..<channelCount {
            let dst = newBuffer.floatChannelData![ch]
            let src = buffer.floatChannelData![ch]
            
            memcpy(dst, src, Int(buffer.frameLength) * MemoryLayout<Float>.size)
            memset(dst.advanced(by: Int(buffer.frameLength)), 0, Int(silenceFrames) * MemoryLayout<Float>.size)
        }
        
        return newBuffer
    }
}

