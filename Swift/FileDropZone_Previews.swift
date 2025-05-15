//
//  FileDropZone_Previews.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct FileDropZone_Previews: PreviewProvider {
    static var previews: some View {
        FileDropZone(droppedFiles: .constant([
            URL(fileURLWithPath: "/Users/example/sample.wav")
        ]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

