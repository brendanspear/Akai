//
//  SampleTaskQueue.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

class SampleTaskQueue {
    private var queue: [AkaiSampleTask] = []

    func enqueue(_ task: AkaiSampleTask) {
        queue.append(task)
    }

    func dequeue() -> AkaiSampleTask? {
        guard !queue.isEmpty else { return nil }
        return queue.removeFirst()
    }

    func peek() -> AkaiSampleTask? {
        return queue.first
    }

    func isEmpty() -> Bool {
        return queue.isEmpty
    }

    func clear() {
        queue.removeAll()
    }
}
