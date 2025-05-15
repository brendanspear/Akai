//
//  SystemVolumeManager.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

class SystemVolumeManager {
    static func getCurrentOutputVolume() -> Float {
        // AVAudioSession is unavailable on macOS.
        // Stubbed method – returns a fixed value for UI compatibility.
        return 0.8
    }

    static func setOutputVolume(_ volume: Float) {
        // Stub – can't adjust system volume on macOS in a sandboxed environment.
        print("System volume change not supported on macOS.")
    }
}
