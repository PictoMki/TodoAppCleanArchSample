//
//  AppState.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import Foundation

class AppState: ObservableObject {
    @Published var taskList: [Task] = [
        Task.getMock(name: "タスク1"),
        Task.getMock(name: "タスク2"),
        Task.getMock(name: "タスク3")
    ]
    
    func updateTaskState(index: Int) {
        taskList[index].isDone = !taskList[index].isDone
    }
    
    func removeTask(index: Int) {
        taskList.remove(at: index)
    }
}
