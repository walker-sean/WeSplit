//
//  ContentView.swift
//  WeSplit
//
//  Created by Sean Walker on 7/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    let tipPercentages = [0, 10, 15, 18, 20, 25]
    
    var totalCost: Double {
        let tipSelection = Double(tipPercentage)
        return checkAmount * (1 + tipSelection / 100.0)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalCost / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Bill Amount")
                }
                
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Number of People")
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Amount")
                }
                
                Section {
                    Text(totalCost, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total Cost")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Total per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
