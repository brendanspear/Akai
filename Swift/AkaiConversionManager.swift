//
//  AkaiConversionManager.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

class AkaiConversionManager {

    static func processSample(
        at url: URL,
        for sampler: AkaiSampler,
        settings: ExportPreferences
    ) -> (convertedSamples: [Int16]?, bitDepth: Int, sampleRate: UInt32)? {

        guard let (samples, sampleRate, bitDepth) = AudioConverter.loadWavPCM16(from: url) else {
            print("Failed to load WAV")
            return nil
        }

        var processedSamples = samples
        var newSampleRate = sampleRate
        var newBitDepth = bitDepth

        if settings.normalize {
            processedSamples = AudioNormalizer.normalize(samples: processedSamples)
        }

        if settings.trimSilence {
            processedSamples = AudioSilenceTrimmer.trimSilence(samples: processedSamples, threshold: 500)
        }

        if settings.addSilence {
            processedSamples = AudioSilenceTrimmer.appendSilence(
                to: processedSamples,
                milliseconds: settings.silenceDurationMs,
                sampleRate: UInt32(sampleRate)
            )
        }

        if settings.autoFixCompatibility {
            if !AkaiProcessor.checkCompatibility(
                samples: processedSamples,
                sampleRate: sampleRate,
                bitDepth: bitDepth,
                sampler: sampler
            ) {
                print("Auto-fix: adjusting sample rate or bit depth")
                newSampleRate = min(sampleRate, sampler.maxSampleRate)
                newBitDepth = sampler.supportedBitDepths.first ?? bitDepth
            }
        }

        return (processedSamples, Int(newBitDepth), newSampleRate)    }

    static func exportSample(
        samples: [Int16],
        to directory: URL,
        originalFile: URL,
        sampleRate: UInt32
    ) -> URL? {
        return OutputDiskWriter.writeWav(
            samples: samples,
            sampleRate: sampleRate,
            bitDepth: 16,
            channels: 1,
            to: directory,
            originalFilename: originalFile.lastPathComponent
        )
    }
}
