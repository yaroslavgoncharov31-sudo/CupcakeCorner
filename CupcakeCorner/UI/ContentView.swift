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
                        Section {
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
