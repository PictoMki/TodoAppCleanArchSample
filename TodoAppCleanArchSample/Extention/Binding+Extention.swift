//
//  Binding+Extention.swift
//  TodoAppCleanArchSample
//
//  Created by 井上知貴 on 2021/07/09.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
