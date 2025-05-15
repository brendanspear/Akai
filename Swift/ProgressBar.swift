//
//  ProgressBar.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct ProgressBar: View {
    var progress: Double  // Value between 0.0 and 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 12)
                    .foregroundColor(Color.gray.opacity(0.3))

                RoundedRectangle(cornerRadius: 6)
                    .frame(width: CGFloat(self.progress) * geometry.size.width, height: 12)
                    .foregroundColor(.blue)
            }
        }
        .frame(height: 12)
    }
}

