//
//  TaskDetailView.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: TaskDetailViewModel
    @Environment(\.presentationMode) var presentation
    let task: Task
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("完了済みにする")
                    Spacer()
                    Button(action: {
                        viewModel.updateTask(allTasks: appState.taskList, taskId: task.id, completed: {
                            self.presentation.wrappedValue.dismiss()
                        })
                    }) {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "checkmark.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.green)
                            .frame(width: 40, height: 40)
                    }
                }.padding(.horizontal, 20)
                .padding(.top, 20)
                Spacer()
                Button(action: {
                    viewModel.removeTask(allTasks: appState.taskList, taskId: task.id, completed: {
                        self.presentation.wrappedValue.dismiss()
                    })
                }) {
                    Text("削除する")
                        .foregroundColor(.red)
                }
            }.navigationBarTitle(task.name)
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(
            viewModel: TaskDetailViewModel(
                updateTaskState: { _ in },
                removeTask: { _ in }
            ),
            task: Task.getMock(name: "テスト")
        )
    }
}
