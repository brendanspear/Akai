//
//  OutputDestination.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

enum OutputDestination: String, CaseIterable {
    case zuluScsi = "ZuluSCSI"
    case gotek = "Gotek"
    case floppyDisk = "Floppy Disk Image"
    case localFolder = "Local Folder"

    var maxFileSizeInBytes: Int {
        switch self {
        case .zuluScsi:
            return 512 * 1024 * 1024  // 512MB is a common FAT32 partition size
        case .gotek:
            return 1_474_560  // 1.44MB
        case .floppyDisk:
            return 1_474_560  // same as Gotek standard image size
        case .localFolder:
            return Int.max  // practically unlimited
        }
    }
}
