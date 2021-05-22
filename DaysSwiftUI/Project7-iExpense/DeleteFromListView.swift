//
//  DeleteFromListView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/22/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items =
            UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            /*
             t’s common to do a bit of a double take when you first see [ExpenseItem].self – what does the .self mean? Well, if we had just used [ExpenseItem], Swift would want to know what we meant – are we trying to make a copy of the class? Were we planning to reference a static property or method? Did we perhaps mean to create an instance of the class? To avoid confusion – to say that we mean we’re referring to the type itself, known as the type object – we write .self after it.
             */
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct DeleteFromListView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: { indexSet in
                    expenses.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                    Button(action: {
                    //let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //self.expenses.items.append(expense)
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: self.expenses)
                /*
                 The presentation mode is controlled by the view’s environment, and links to the isPresented parameter for our sheet – that Boolean gets set to true by us to show AddView, but will be flipped back to false by the environment when we call dismiss() on the presentation mode.
                 */
            })
        }
    }
}

struct DeleteFromListView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteFromListView()
    }
}
