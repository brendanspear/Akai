
import Foundation

class SettingsManager {
    private let defaults = UserDefaults.standard

    func saveSettings(sampleRate: Int, bitDepth: Int, format: SampleFormat) {
        defaults.set(sampleRate, forKey: "sampleRate")
        defaults.set(bitDepth, forKey: "bitDepth")
        defaults.set(format.rawValue, forKey: "outputFormat")
    }

    func loadSettings() -> (sampleRate: Int, bitDepth: Int, format: SampleFormat) {
        let sampleRate = defaults.integer(forKey: "sampleRate")
        let bitDepth = defaults.integer(forKey: "bitDepth")
        let formatString = defaults.string(forKey: "outputFormat") ?? SampleFormat.pcm16.rawValue
        let format = SampleFormat(rawValue: formatString) ?? .pcm16
        return (sampleRate, bitDepth, format)
    }
}
