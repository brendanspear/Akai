//
//  TaskRunner.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

class TaskRunner {
    
    /// Runs a background task with optional completion on the main thread.
    /// - Parameters:
    ///   - task: The work to perform in the background.
    ///   - completion: Code to run on the main thread after the task is finished.
    static func runInBackground(task: @escaping () -> Void, completion: (() -> Void)? = nil) {
        let workItem = DispatchWorkItem {
            task()
            if let completion = completion {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
    }
}
