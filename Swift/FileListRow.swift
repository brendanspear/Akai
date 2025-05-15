//
//  FileListRow.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import SwiftUI

struct FileListRow: View {
    let file: URL

    var body: some View {
        HStack {
            Image(systemName: "waveform")
                .foregroundColor(.blue)
            Text(file.lastPathComponent)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.middle)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
