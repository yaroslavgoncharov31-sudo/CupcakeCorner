import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var orderWasPlaced = false
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
                Button("Place order") {
                    Task {
                        guard let decoded = try? await NetworkManager.placeOrder(order: order) else {
                            confirmationMessage = "Failed to proceed order. Please try again"
                            showingConfirmation = true
                            return
                        }
                        confirmationMessage = "Your order for \(decoded.quantity)x \(order.type) cupcakes is on it's way!"
                        showingConfirmation = true
                    }
                    orderWasPlaced = true
                }
                    .padding()
            }
        }
        .onDisappear {
            if orderWasPlaced {
                order.reset()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order status", isPresented: $showingConfirmation) {
            Button("OK") {
                path = NavigationPath()
            }
        } message: {
            Text(confirmationMessage)
        }


    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    CheckoutView(order: Order(), path: $path)
}
