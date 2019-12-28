//
//  ContentView.swift
//  BetterRest
//
//  Created by Yingyot Nebbua on 2019/12/28.
//  Copyright © 2019 Yingyot Nebbua. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
 
    var idealBedtime: String {
        var calculatedBedtime = ""
        let model = SleepCalculator()
               let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
               let hour = (components.hour ?? 0) * 60 * 60
               let minute = (components.minute ?? 0) * 60
               
               do {
                   let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                   let sleepTime = wakeUp - prediction.actualSleep
                   
                   let formatter = DateFormatter()
                   formatter.timeStyle = .short
                   calculatedBedtime = formatter.string(from: sleepTime)
                   
               } catch {
                   return "Error"
               }
        
               return calculatedBedtime
    }
        
    //MARK: Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desire amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                    
                Section(header: Text("Daily coffee intake")) {
                    Picker("Coffee amount", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            Text($0 > 1 ? "\($0) cups" : "\($0) cup")
                        }
                    }
                }
                
                Section(header: Text("You should go to bed at...")) {
                    Text(idealBedtime)
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
