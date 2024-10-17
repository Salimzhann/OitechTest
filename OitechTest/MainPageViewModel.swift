import UIKit

class MainPageViewModel {
    
    private let apiKey = "b3955bba0fmsh04de82cd874cba3p1462fejsn70d5a4ecad54"
    private let urlString = "https://movies-tv-shows-database.p.rapidapi.com/?page=1"

    func fetchTrendingMovies() {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("get-trending-movies", forHTTPHeaderField: "Type")
        request.addValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response:", response as? HTTPURLResponse)
                return
            }

            guard let data = data else {
                print("No data found")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Trending Movies:", json)
                }
            } catch {
                print("JSON parsing error:", error)
            }
        }

        task.resume()
    }

}
