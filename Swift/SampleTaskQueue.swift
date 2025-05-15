//
//  SampleTaskQueue.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

class SampleTaskQueue: ObservableObject {
    @Published private(set) var tasks: [SampleProcessingTask] = []
    @Published private(set) var currentTaskIndex: Int? = nil
    @Published private(set) var isProcessing: Bool = false

    var currentTask: SampleProcessingTask? {
        guard let index = currentTaskIndex, index < tasks.count else {
            return nil
        }
        return tasks[index]
    }

    func add(task: SampleProcessingTask) {
        tasks.append(task)
    }

    func addAll(_ newTasks: [SampleProcessingTask]) {
        tasks.append(contentsOf: newTasks)
    }

    func clear() {
        tasks.removeAll()
        currentTaskIndex = nil
        isProcessing = false
    }

    func nextTask() -> SampleProcessingTask? {
        if currentTaskIndex == nil {
            currentTaskIndex = 0
        } else {
            currentTaskIndex! += 1
        }

        guard let index = currentTaskIndex, index < tasks.count else {
            currentTaskIndex = nil
            return nil
        }

        return tasks[index]
    }

    func markFinished() {
        if let index = currentTaskIndex, index < tasks.count {
            print("Finished processing task \(index + 1)/\(tasks.count)")
        }

        if currentTaskIndex != nil {
            currentTaskIndex! += 1
        }

        if currentTaskIndex == nil || currentTaskIndex! >= tasks.count {
            currentTaskIndex = nil
            isProcessing = false
        }
    }

    func startProcessing() {
        guard !tasks.isEmpty else { return }
        currentTaskIndex = 0
        isProcessing = true
    }
}

