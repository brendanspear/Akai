//
//  StatusIndicatorView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct StatusIndicatorView: View {
    var message: String
    var systemImage: String = "info.circle"
    var color: Color = .blue

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .imageScale(.large)

            Text(message)
                .foregroundColor(color)
                .font(.body)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

