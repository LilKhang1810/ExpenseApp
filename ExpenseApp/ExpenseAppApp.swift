//
//  ExpenseAppApp.swift
//  ExpenseApp
//
//  Created by Nguyễn Khang Hữu on 06/03/2024.
//

import SwiftUI
import SwiftData
@main
struct ExpenseAppApp: App {
    let modelContainer: ModelContainer
        
        init() {
            do {
                modelContainer = try ModelContainer(for: Expense.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
