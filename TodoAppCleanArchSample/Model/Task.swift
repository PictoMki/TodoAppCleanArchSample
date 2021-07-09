//
//  Task.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import Foundation

struct Task: Identifiable {
    var id: String
    var name: String
    var isDone: Bool
    let createdAt: Date
    var updatedAt: Date
    
    static func getMock(name: String) -> Self {
        return Task(
            id: UUID().uuidString,
            name: name,
            isDone: false,
            createdAt: Date(),
            updatedAt: Date())
    }
}
