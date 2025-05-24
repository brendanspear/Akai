//  AkaiSampleTask.swift
//  AkaiSConvert

import Foundation

struct AkaiSampleTask {
    let fileURL: URL
    let sampler: SamplerType
    let outputFolderURL: URL?

    func run() async -> Bool {
        // Placeholder for real conversion logic
        try? await Task.sleep(nanoseconds: 500_000_000)
        return true
    }
}
