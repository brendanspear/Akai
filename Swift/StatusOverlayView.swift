//
//  StatusOverlayView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct StatusOverlayView: View {
    let message: String
    let isVisible: Bool

    var body: some View {
        Group {
            if isVisible {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                        Text(message)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(32)
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(16)
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: isVisible)
            }
        }
    }
}

