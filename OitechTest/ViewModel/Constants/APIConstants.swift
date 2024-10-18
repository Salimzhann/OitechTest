import Foundation

enum APIConstants {
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }()
    
    static let baseURL = "https://movies-tv-shows-database.p.rapidapi.com/"
}
