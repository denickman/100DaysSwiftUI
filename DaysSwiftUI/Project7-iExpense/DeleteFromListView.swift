//
//  DeleteFromListView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/22/21.
//

import SwiftUI

enum ItemFeature: Int, CaseIterable {
    case edit = 0
    case delete = 1
}

enum ExpensiveLevel: Int, Codable {
    case low = 10
    case medium = 100
    case heigh = 1000
    case unknown = 1000000
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
    let level: ExpensiveLevel
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
    
    let itemImages = ["delete.left", "pencil.circle"]

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                            
                            HStack {
                                Text("Cost:")
                                    .font(.headline)
                                
                                let params = getExpenseParams(amount: item.level.rawValue)
                                
                                Text("$\(item.amount)")
                                    .font(.system(size: CGFloat(params.fontSize)))
                                    .foregroundColor(params.color)
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            ForEach(0..<itemImages.count) { index in
                                Button(action: {
                                    let itemIndex = ItemFeature(rawValue: index)!
                                    itemTapped(at: itemIndex)
                                }) {
                                    Image(systemName: self.itemImages[index])
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    expenses.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                        // self.showingAddExpense.toggle() // another option for do it
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
    
    private func itemTapped(at index: ItemFeature) {
        switch index {
        case .edit:
            print("Edit")
            
        case .delete:
            print("Delete")
        }
    }
 
       private func getExpenseParams(amount: Int) -> (fontSize: Int, color: Color) {
           switch amount {
           case 0...10:
               return (12, .blue)
               
           case 11...100:
               return (15, .green)
               
           case 101...1000:
               return (18, .orange)
               
           default:
               return (20, .red)
           }
       }
       
}
