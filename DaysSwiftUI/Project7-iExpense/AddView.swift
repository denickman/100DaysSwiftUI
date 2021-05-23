//
//  AddView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/22/21.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var fuckOffMode
    /*
     The presentation mode is controlled by the view’s environment, and links to the isPresented parameter for our sheet – that Boolean gets set to true by us to show AddView, but will be flipped back to false by the environment when we call dismiss() on the presentation mode.
     */
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var isAmountWrong = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                
                guard let actualAmount = Int(self.amount) else {
                    isAmountWrong.toggle()
                    return
                }

                let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount, level: getExpensiveLevel(actualAmount))
                
                self.expenses.items.append(item)
                self.fuckOffMode.wrappedValue.dismiss()
            }
            )
            .alert(isPresented: $isAmountWrong, content: {
                Alert(title: Text("Alert"),
                      message: Text("\(self.amount) is very wrong man! Need to change!"),
                      dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    private func getExpensiveLevel(_ actualAmount: Int) -> ExpensiveLevel {
        
        var expensiveLevel: ExpensiveLevel
        
        switch actualAmount {
        case 0...10:
            expensiveLevel = .low
            
        case 10...100:
            expensiveLevel = .medium
            
        case 100...1000:
            expensiveLevel = .heigh
            
        default:
            expensiveLevel = .unknown
        }
        
        return expensiveLevel
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
