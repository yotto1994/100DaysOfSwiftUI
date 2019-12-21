//
//  ContentView.swift
//  WeSplit
//
//  Created by Yingyot Nebbua on 2019/12/21.
//  Copyright © 2019 Yingyot Nebbua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Properties
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
   
    let tipPercentages = [10, 15, 20, 25, 0]
    @State private var tipPercentage = 2
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandAmount = orderAmount + tipValue
        return grandAmount
    }
    
    var totalPerPerson: Double {
        let totalPerson = Double(numberOfPeople) ?? 1
        let totalPerPerson = grandTotal / totalPerson
        return totalPerPerson
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amout", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("Total Amount: \(grandTotal, specifier: "%.2f")$")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("\(totalPerPerson, specifier: "%.2f")$")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
