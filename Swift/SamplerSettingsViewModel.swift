//  SamplerSettingsViewModel.swift

import SwiftUI

class SamplerSettingsViewModel: ObservableObject {
    @Binding var settings: ConversionSettings

    init(settings: Binding<ConversionSettings>) {
        self._settings = settings
    }
}
