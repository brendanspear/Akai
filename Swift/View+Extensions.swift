//
//  View+Extensions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import SwiftUI

extension View {
    /// Adds a styled section label with consistent spacing
    func sectionLabel(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(text)
                .font(.headline)
                .foregroundColor(.primary)
            Divider()
        }
        .padding(.vertical, 4)
    }

    /// Adds a rounded card-style background with macOS-compatible styling
    func cardBackground() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))  // Replaces systemGray6
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
            )
    }

    /// Adds a subtle inset group box style using cross-platform fill color
    func insetGroupBox() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.15))  // Replaces quaternarySystemFill
            .cornerRadius(8)
    }
}
