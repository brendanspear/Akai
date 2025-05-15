//
//  DragDropHandler.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AppKit

protocol DragDropHandlerDelegate: AnyObject {
    func didReceiveDraggedFiles(_ fileURLs: [URL])
}

class DragDropHandler: NSView {
    weak var delegate: DragDropHandlerDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([.fileURL])
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        registerForDraggedTypes([.fileURL])
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }

    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pasteboard = sender.draggingPasteboard
        guard let items = pasteboard.pasteboardItems else { return false }

        let fileURLs: [URL] = items.compactMap {
            guard let str = $0.string(forType: .fileURL) else { return nil }
            return URL(string: str)
        }

        delegate?.didReceiveDraggedFiles(fileURLs)
        return true
    }
}

