//
//  SampleProcessingTask.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SampleProcessingTask {
    let inputURL: URL
    let outputDirectory: URL
    let sampler: AkaiSampler
    let normalize: Bool
    let trimOptions: TrimOptions
    let enforceCompatibility: Bool
    let autoFix: Bool
}

