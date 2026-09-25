import Foundation

enum AppConfig {
    static var reqresAPIKey: String {
        Bundle.main.object(forInfoDictionaryKey: "REQRES_API_KEY") as? String ?? ""
    }
}
