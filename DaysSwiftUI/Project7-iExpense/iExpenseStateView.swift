//
//  iExpenseStateView.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 5/21/21.
//

import SwiftUI

class User: ObservableObject {
    // protocol ObservableObject means we want other things to be able to monitor this for changes
    @Published var name = "Alex"
    @Published var surname = "Megane"
}

struct SecondView: View {
    
    @Environment(\.presentationMode) var fuckOffMode
    
    var name: String
    
    var body: some View {
        Text("Hello \(name)!")
        Button("Dismiss") {
            self.fuckOffMode.wrappedValue.dismiss()
        }
    }
}

struct iExpenseStateView: View {
    
    @ObservedObject var user = User()
    @State private var isShowingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Name: \(user.name) \(user.surname)")
                TextField("First name:", text: $user.name)
                TextField("Last name:", text: $user.surname)
                
                Divider()
                
                Button("Show Sheet") {
                    self.isShowingSheet.toggle()
                }
                .sheet(isPresented: $isShowingSheet) {
                    SecondView(name: "Everyone")
                }
                
                Divider()
                
                VStack {
                    List {
                        ForEach(numbers, id: \.self) {
                            Text("\($0)")
                        }
                        .onDelete(perform: removeRows)
                    }
                    
                    Button("Add Number") {
                        self.numbers.append(self.currentNumber)
                        self.currentNumber += 1
                    }
                }
            }
            .padding(30)
        }
        .navigationBarItems(leading: EditButton())
        .navigationTitle("Fuck Off")
    }
    
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct iExpenseStateView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseStateView()
    }
}
