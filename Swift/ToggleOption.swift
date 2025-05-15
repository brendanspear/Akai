//
//  ToggleOption.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct ToggleOption: Identifiable, Hashable {
    var id: String { key }
    let key: String
    let label: String
    var isOn: Bool

    init(_ key: String, label: String, isOn: Bool = false) {
        self.key = key
        self.label = label
        self.isOn = isOn
    }
}

