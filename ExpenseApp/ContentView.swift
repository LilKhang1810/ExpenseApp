//
//  ContentView.swift
//  ExpenseApp
//
//  Created by Nguyễn Khang Hữu on 06/03/2024.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort:\Expense.date) var expenses : [Expense]
    @State var showAddItemSheet: Bool = false
    @State private var expenseToUpdate: Expense?
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses){expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToUpdate = expense
                        }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                })
            }
            .navigationTitle("Expense")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showAddItemSheet, content: {
                AddItemSheet()
            })
            .sheet(item: $expenseToUpdate, content: { expense in
                UpdateItemSheet(expense: expense)
            })
            .toolbar {
                if !expenses.isEmpty{
                    Button("Add expense",systemImage: "plus") {
                        showAddItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Expense", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding new expanse to keep track")
                    }, actions: {
                        Button(action: {
                            showAddItemSheet=true
                        }) {
                            Text("Add expense item")
                        }
                    })
                }
            }
        }
    }
}
struct ExpenseCell: View {
    let expense: Expense
    var body: some View {
        HStack{
            Text(expense.date,format: .dateTime.month(.abbreviated).day())
                .frame(width: 70,alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value,format: .currency(code: "VND"))
        }
    }
}
struct AddItemSheet:View {
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    var body: some View {
        NavigationStack{
            Form{
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date,displayedComponents: .date)
                TextField("Value", value: $value, format:.currency(code: "VND"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save"){
                        let expense = Expense(date: date, name: name, value: value)
                        context.insert(expense)
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement:.topBarLeading) {
                    Button("Cancel"){dismiss()}
                }
            }
        }
    }
}
struct UpdateItemSheet: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var expense: Expense
    var body: some View {
        NavigationStack{
            Form{
                TextField("Expense Name", text:$expense.name)
                DatePicker("Date", selection: $expense.date,displayedComponents: .date)
                TextField("Value",value: $expense.value, format:.currency(code: "VND"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done"){dismiss()}
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
