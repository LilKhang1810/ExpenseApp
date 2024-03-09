//
//  Expense.swift
//  ExpenseApp
//
//  Created by Nguyễn Khang Hữu on 06/03/2024.
//

import Foundation
import SwiftData
@Model
class Expense{
    var date: Date
    var name: String
    var value: Double
    init(date: Date, name: String, value: Double) {
        self.date = date
        self.name = name
        self.value = value
    }
}
