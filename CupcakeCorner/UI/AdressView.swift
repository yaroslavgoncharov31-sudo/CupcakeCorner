import SwiftUI

struct AdressView: View {
    @Bindable var order: Order
    @Binding var path: NavigationPath

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
                TextField("Email", text: $order.email)
            }
            Section {
                Button("Proceed to checkout") {
                    order.saveAddress()
                    path.append(Route.checkoutView)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    AdressView(order: Order(), path: $path)
}
