//
//  CompatibilityCheckResultView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct CompatibilityCheckResultView: View {
    var results: [CompatibilityCheckResult]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Compatibility Results")
                .font(.headline)

            if results.isEmpty {
                Text("No results to display.")
                    .italic()
            } else {
                List(results) { result in
                    VStack(alignment: .leading) {
                        Text(result.filename)
                            .font(.subheadline)
                            .bold()
                        if result.isCompatible {
                            Text("✓ Compatible").foregroundColor(.green)
                        } else {
                            VStack(alignment: .leading) {
                                Text("⚠ Incompatible").foregroundColor(.red)
                                ForEach(result.issues, id: \.self) { issue in
                                    Text("- \(issue)").font(.caption)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
    }
}

