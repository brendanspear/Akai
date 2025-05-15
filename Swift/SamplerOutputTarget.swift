//
//  SamplerOutputTarget.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SamplerOutputTarget {
    let path: String
    let formatExtension: String
    
    static func forSampler(_ sampler: AkaiSampler, basePath: String, originalFile: String) -> SamplerOutputTarget {
        let ext: String
        switch sampler {
        case .s900:
            ext = "s900"
        case .s1000:
            ext = "s1000"
        case .s3000:
            ext = "s3000"
        }
        let outputPath = OutputPathHelper.generateOutputPath(in: URL(fileURLWithPath: basePath), forOriginalFile: originalFile, newExtension: ext)
        return SamplerOutputTarget(path: outputPath, formatExtension: ext)
    }
    
    func asURL() -> URL {
        return URL(fileURLWithPath: path)
    }
}

