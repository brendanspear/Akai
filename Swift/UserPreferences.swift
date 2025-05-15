//
//  UserPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct UserPreferences: Codable {
    var selectedSampler: AkaiSampler
    var autoFixIncompatibilities: Bool
    var normalizeAudio: Bool
    var trimSilence: Bool
    var addSilenceMs: UInt32
    var showAdvancedWarnings: Bool
    
    static let defaultPreferences = UserPreferences(
        selectedSampler: .s1000,
        autoFixIncompatibilities: true,
        normalizeAudio: false,
        trimSilence: false,
        addSilenceMs: 0,
        showAdvancedWarnings: true
    )
    
    private static let key = "UserPreferencesKey"
    
    static func load() -> UserPreferences {
        if let data = UserDefaults.standard.data(forKey: key),
           let prefs = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            return prefs
        }
        return defaultPreferences
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: UserPreferences.key)
        }
    }
}

