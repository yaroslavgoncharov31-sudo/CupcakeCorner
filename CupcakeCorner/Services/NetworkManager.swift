import Foundation

struct NetworkManager {
    static func placeOrder(order: Order) async throws -> Order? {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return nil
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("free_user_3JGeWruB3zwWbd6sgNe6riuXbfn", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print(String(data: data, encoding: .utf8) ?? "No response")
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            return decodedOrder
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            return nil
        }
    }
}
