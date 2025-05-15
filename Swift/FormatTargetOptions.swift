//
//  FormatTargetOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct FormatTargetOptions: View {
    @Binding var selectedFormat: FormatTarget

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Target Format")
                .font(.headline)

            Picker("Target Format", selection: $selectedFormat) {
                ForEach(FormatTarget.allCases, id: \.self) { format in
                    Text(format.displayName).tag(format)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.vertical, 6)
        .help("Choose your target format such as Floppy (720KB), SCSI SD, etc.")
    }
}

enum FormatTarget: String, CaseIterable {
    case floppy = "Floppy"
    case sdcard = "SCSI SD"
    case gotek = "Gotek"
    case auto = "Auto"

    var displayName: String {
        switch self {
        case .floppy: return "Floppy (720KB)"
        case .sdcard: return "ZuluSCSI"
        case .gotek: return "Gotek"
        case .auto: return "Auto"
        }
    }

    var maxFileSizeBytes: Int {
        switch self {
        case .floppy: return 720 * 1024
        case .sdcard: return 32 * 1024 * 1024  // 32MB for example
        case .gotek: return 1440 * 1024
        case .auto: return Int.max
        }
    }
}

