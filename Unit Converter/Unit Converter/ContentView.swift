//
//  ContentView.swift
//  Unit Converter
//
//  Created by Yingyot Nebbua on 2019/12/23.
//  Copyright © 2019 Yingyot Nebbua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK Properties
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @State private var inputNumber = ""
    var outputValue: Double {
        let inputValue = Double(inputNumber) ?? 0.0
        let outputNumber = convertUnit(inputUnit: inputUnit, outputUnit: outputUnit, inputValue: inputValue)
        return outputNumber
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please select inpupt unit")) {
                    Picker("Select input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Please select output unit")) {
                    Picker("Select output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Input and output values")) {
                    TextField("Please enter input value", text: $inputNumber)
                        .keyboardType(.decimalPad)
                    Text("Output value: \(outputValue, specifier: "%.2f")")
                }
            }.navigationBarTitle("Unit Converter", displayMode: .large)
        }
    }
    
    
    //MARK Methods
    func fahrenheitToCelsius(F: Double) -> Double {
        let C = (F - 32) * 5 / 9
        return C
    }
    
    func kelvinToCelsius(K: Double) -> Double {
        let C = K - 273.15
        return C
    }
    
    func celsiusToFahrenheit(C: Double) -> Double {
        let F = 9 / 5 * C + 32
        return F
    }
    
    func celsiusToKelvin(C: Double) -> Double {
        let K = C + 273.15
        return K
    }
    
    func convertUnit(inputUnit: String, outputUnit: String, inputValue: Double) -> Double {
        var celsiusValue = 0.0
        var outputValue = 0.0
        
        //step 1: convert anything into celsius degree
        if inputUnit == "Fahrenheit" {
            celsiusValue = fahrenheitToCelsius(F: inputValue)
        }
        else if inputUnit == "Kelvin" {
            celsiusValue = kelvinToCelsius(K: inputValue)
        } else {
            celsiusValue = inputValue
        }
        
        //step 2 convert celsius degree into the desired unit
        if outputUnit == "Fahrenheit" {
            outputValue = celsiusToFahrenheit(C: celsiusValue)
        }
        else if outputUnit == "Kelvin" {
            outputValue = celsiusToKelvin(C: celsiusValue)
        } else {
            outputValue = celsiusValue
        }
        
        return outputValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
