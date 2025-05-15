import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var selectedSampler: AkaiSampler = .s1000
    @Published var exportPreferences: ExportPreferences = ExportPreferences()
    @Published var selectedFiles: [URL] = []
    @Published var conversionLog: String = ""
    @Published var isConverting: Bool = false
    @Published var showSuccessAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    func reset() {
        selectedFiles = []
        conversionLog = ""
        isConverting = false
        showSuccessAlert = false
        showErrorAlert = false
        errorMessage = ""
    }
}
