//
//  TrimOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct TrimOptions {
    var trimSilence: Bool = false
    var addSilence: Bool = false
    var silenceDurationMS: Int = 0
    var silenceThreshold: Int16 = 300  // samples below this are considered silence

    func shouldProcess() -> Bool {
        return trimSilence || (addSilence && silenceDurationMS > 0)
    }
}
