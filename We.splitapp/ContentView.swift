import SwiftUI

struct ContentView: View {
    
    @State private var totalAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10 // Using Int for consistency
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Computed property to calculate the total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)

        let tipValue = totalAmount / 100 * tipSelection
        let grandTotal = totalAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .focused($amountIsFocused)
                        .keyboardType(.decimalPad)
                }
                
                Section("Number of People") {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            // Set the background color on the Form itself
            // Ensures Form's background shows the custom color
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
