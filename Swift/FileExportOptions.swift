//
//  FileExportOptions.Swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct FileExportOptions {
    enum OutputFormat: String {
        case wav
        case akaiS900
        case akaiS1000
        case akaiS3000
    }

    var format: OutputFormat = .akaiS900
    var destinationPath: String = ""
    var overwriteExisting: Bool = false
    var autoGenerateName: Bool = true
}

