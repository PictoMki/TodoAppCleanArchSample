//
//  TodoAppCleanArchSampleApp.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import SwiftUI

@main
struct TodoAppCleanArchSampleApp: App {
    var body: some Scene {
        WindowGroup {
            TaskListView(viewModel: TaskListViewModel())
                .environmentObject(AppState())
        }
    }
}
