import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var orderWasPlaced = false
    @State private var isPlacingOrder = false
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                if isPlacingOrder {
                    ProgressView()
                } else {
                    Button("Place order") {
                        isPlacingOrder = true
                        Task {
                            await placeOrder()
                        }
                    }
                    .disabled(isPlacingOrder)
                    .padding()
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order status", isPresented: $showingConfirmation) {
            Button("OK") {
                if orderWasPlaced {
                    path = NavigationPath()
                    order.reset()
                }
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    private func placeOrder() async {
        isPlacingOrder = true
        defer { isPlacingOrder = false }

        do {
            let finalOrder = try await NetworkManager.placeOrder(order: order)
            confirmationMessage = "Your order for \(finalOrder.quantity)x \(finalOrder.type.rawValue) cupcakes is on its way!"
            orderWasPlaced = true
        } catch {
            confirmationMessage = error.localizedDescription
            orderWasPlaced = false
        }
        showingConfirmation = true
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    CheckoutView(order: Order(), path: $path)
}
