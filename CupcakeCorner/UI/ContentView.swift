import SwiftUI

struct ContentView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(CupcakeType.allCases, id: \.self) { flavour in
                            Text(flavour.rawValue)
                                .tag(flavour)
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn:  $order.extraFrosting.animation())

                        Toggle("Add extra sprinkles", isOn:  $order.addSprinkles.animation())
                    } 
                }
                Section {
                    NavigationLink("Adress details") {
                        AdressView(order: order)
                    }
                }
            }
        }
        .navigationTitle("Cupcake Corner")
    }
}

#Preview {
    ContentView()
}
