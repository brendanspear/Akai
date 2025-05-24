//
//  SamplerSettingsViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import Foundation
import SwiftUI

class SamplerSettingsViewModel: ObservableObject {
    @Binding var settings: ConversionSettings

    init(settings: Binding<ConversionSettings>) {
        self._settings = settings
    }
}
