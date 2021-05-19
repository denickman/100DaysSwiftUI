//
//  ContentView2.swift
//  WeSplit
//
//  Created by Denis Yaremenko on 5/13/21.
//

import SwiftUI

struct WeSplitView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmountPerCheck: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount + totalPerPerson * peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount of check:")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Check + tips:")) {
                    Text("$\(totalAmountPerCheck, specifier: "%.2f")")
                }
                
                Section(header: Text("How Much?")) {
                    Text("How much tip do you want to leave?")
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
