import Foundation
import AVFoundation

class SilenceTrimmer {
    
    /// Trim leading and trailing silence below the threshold
    static func trimSilence(from buffer: AVAudioPCMBuffer,
                            threshold: Float = 0.001,
                            minimumDuration: Float = 0.01) -> AVAudioPCMBuffer {
        let sampleRate = Float(buffer.format.sampleRate)
        let frameLength = Int(buffer.frameLength)
        let channelCount = Int(buffer.format.channelCount)
        let minFrames = Int(minimumDuration * sampleRate)
        
        var startIndex = 0
        var endIndex = frameLength - 1
        
        // Find first non-silent frame
        outerStart: for i in 0..<frameLength {
            for c in 0..<channelCount {
                if let data = buffer.floatChannelData?[c], abs(data[i]) > threshold {
                    startIndex = max(0, i - minFrames)
                    break outerStart
                }
            }
        }
        
        // Find last non-silent frame
        outerEnd: for i in stride(from: frameLength - 1, through: 0, by: -1) {
            for c in 0..<channelCount {
                if let data = buffer.floatChannelData?[c], abs(data[i]) > threshold {
                    endIndex = min(frameLength - 1, i + minFrames)
                    break outerEnd
                }
            }
        }
        
        let newLength = max(0, endIndex - startIndex + 1)
        guard newLength > 0,
              let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                         sampleRate: buffer.format.sampleRate,
                                         channels: buffer.format.channelCount,
                                         interleaved: false),
              let trimmed = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(newLength)) else {
            return buffer
        }
        
        trimmed.frameLength = AVAudioFrameCount(newLength)
        
        for c in 0..<channelCount {
            if let src = buffer.floatChannelData?[c],
               let dst = trimmed.floatChannelData?[c] {
                memcpy(dst, src.advanced(by: startIndex), newLength * MemoryLayout<Float>.size)
            }
        }
        
        return trimmed
    }
    
    /// Pad silence to the end of the buffer
    static func padSilence(to buffer: AVAudioPCMBuffer, milliseconds: Int) -> AVAudioPCMBuffer {
        let sampleRate = buffer.format.sampleRate
        let framesToAdd = AVAudioFrameCount(Double(milliseconds) * sampleRate / 1000.0)
        let newFrameLength = buffer.frameLength + framesToAdd
        
        guard let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                         sampleRate: sampleRate,
                                         channels: buffer.format.channelCount,
                                         interleaved: false),
              let padded = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: newFrameLength) else {
            return buffer
        }
        
        padded.frameLength = newFrameLength
        
        let channelCount = Int(buffer.format.channelCount)
        for c in 0..<channelCount {
            if let src = buffer.floatChannelData?[c],
               let dst = padded.floatChannelData?[c] {
                memcpy(dst, src, Int(buffer.frameLength) * MemoryLayout<Float>.size)
                memset(dst.advanced(by: Int(buffer.frameLength)), 0, Int(framesToAdd) * MemoryLayout<Float>.size)
            }
        }
        
        return padded
    }
}
