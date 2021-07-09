//
//  TaskListViewModel.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import Foundation

enum ViewStyle: String {
    case isCompleted = "完了済"
    case isNotCompleted = "未完了"
}

enum SortType: String, CaseIterable, Identifiable {
    case createdAtAsc = "作成時刻の昇順"
    case createdAtDesc = "作成時刻の降順"
    case updatedAtAsc = "更新時刻の昇順"
    case updatedAtDesc = "更新時刻の降順"
    
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .createdAtAsc, .updatedAtAsc:
            return "arrow.up.circle"
        case .createdAtDesc, .updatedAtDesc:
            return "arrow.down.circle"
        }
    }
}

class TaskListViewModel: ObservableObject {
    private var allTasks: [Task] = []
    @Published var viewStyle: ViewStyle = .isNotCompleted
    @Published var sortType: SortType = .createdAtAsc
    @Published var displayTaskList: [Task] = []
    
    func setInitData(allTasks: [Task]) {
        self.allTasks = allTasks
        setDisplayTasks()
    }
    
    func changeViewStyle(viewStyle: ViewStyle) {
        self.viewStyle = viewStyle
        setDisplayTasks()
        sortTasks()
    }
    
    func updateDisplayTasks(allTasks: [Task]) {
        self.allTasks = allTasks
        setDisplayTasks()
        sortTasks()
    }
    
    func sortDisplayTasks(sortType: SortType) {
        self.sortType = sortType
        sortTasks()
    }
    
    private func setDisplayTasks() {
        switch viewStyle {
        case .isNotCompleted:
            displayTaskList = allTasks.filter { task in !task.isDone }
        case .isCompleted:
            displayTaskList = allTasks.filter { task in task.isDone }
        }
    }
    
    private func sortTasks() {
        switch sortType {
        case .createdAtAsc:
            displayTaskList = displayTaskList.sorted(by: { pre, now in pre.createdAt < now.createdAt })
        case .createdAtDesc:
            displayTaskList = displayTaskList.sorted(by: { pre, now in pre.createdAt > now.createdAt })
        case .updatedAtAsc:
            displayTaskList = displayTaskList.sorted(by: { pre, now in pre.updatedAt < now.updatedAt })
        case .updatedAtDesc:
            displayTaskList = displayTaskList.sorted(by: { pre, now in pre.updatedAt > now.updatedAt })
        }
    }
}
