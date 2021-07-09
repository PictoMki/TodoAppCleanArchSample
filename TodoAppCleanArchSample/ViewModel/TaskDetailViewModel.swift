//
//  TaskDetailViewModel.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    private let updateTaskState: (Int) -> Void
    private let removeTask: (Int) -> Void
    
    init(updateTaskState: @escaping (Int) -> Void,
         removeTask: @escaping (Int) -> Void) {
        self.updateTaskState = updateTaskState
        self.removeTask = removeTask
    }
    
    func updateTask(allTasks: [Task], taskId: String, completed: @escaping () -> Void) {
        if let index = allTasks.firstIndex(where: { task in task.id == taskId }) {
            self.updateTaskState(index)
            completed()
        }
    }
    
    func removeTask(allTasks: [Task], taskId: String, completed: @escaping () -> Void) {
        if let index = allTasks.firstIndex(where: { task in task.id == taskId }) {
            self.removeTask(index)
            completed()
        }
    }
}
