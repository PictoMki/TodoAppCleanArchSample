//
//  TaskListView.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import SwiftUI
import Combine

struct TaskListView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: TaskListViewModel
    @State var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Menu {
                        ForEach(SortType.allCases) { sortType in
                            Button {
                                viewModel.sortDisplayTasks(sortType: sortType)
                            } label: {
                                Text(sortType.rawValue)
                                Image(systemName: sortType.imageName)
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                            Text(viewModel.sortType.rawValue)
                                .foregroundColor(.black)
                        }.padding(.trailing ,20)
                        
                    }
                }
                List {
                    ForEach(viewModel.displayTaskList) { task in
                        NavigationLink(
                            task.name,
                            destination: TaskDetailView(
                                viewModel: TaskDetailViewModel(
                                    updateTaskState: appState.updateTaskState,
                                    removeTask: appState.removeTask
                                ),
                                task: task
                            )
                        )
                    }
                }
                Picker("", selection: $viewModel.viewStyle.onChange(viewModel.changeViewStyle)) {
                    Text(ViewStyle.isNotCompleted.rawValue)
                        .tag(ViewStyle.isNotCompleted)
                    Text(ViewStyle.isCompleted.rawValue)
                        .tag(ViewStyle.isCompleted)
                                
                }.pickerStyle(SegmentedPickerStyle())
            }.navigationBarTitle("タスク管理アプリ")
        }.onAppear(perform: {
            viewModel.setInitData(allTasks: appState.taskList)
            setTaskBinding()
        })
    }
    
    func setTaskBinding() {
        appState.$taskList.sink(receiveValue: { taskList in
            viewModel.updateDisplayTasks(allTasks: taskList)
        }).store(in: &cancellables)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: TaskListViewModel())
    }
}
