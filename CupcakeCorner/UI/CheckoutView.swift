import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

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
                            return
                        }
                        confirmationMessage = "Your order for \(decoded.quantity)x \(order.type) cupcakes is on it's way!"
                        showingConfirmation = true
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }


    }
}

#Preview {
    CheckoutView(order: Order())
}
