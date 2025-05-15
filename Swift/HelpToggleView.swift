//
//  HelpToggleView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct HelpToggleView: View {
    @Binding var isHelpVisible: Bool

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isHelpVisible.toggle()
            }) {
                Label("Toggle Help", systemImage: "questionmark.circle")
            }
            .buttonStyle(BorderlessButtonStyle())
            .help("Show or hide tooltips and help labels")
        }
        .padding(.trailing)
    }
}

