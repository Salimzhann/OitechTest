import UIKit

final class MovieDetailViewModel {
    
    private let urlString: String = APIConstants.baseURL
    private(set) var stars: [String] = []
    
    func fetchData(id: String, completion: @escaping (MovieDetail?) -> Void) {
        guard let url = URL(string: "\(urlString)?movieid=\(id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("get-movie-details", forHTTPHeaderField: "Type")
        request.addValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(APIConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error:", error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response: \(String(describing: response))")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data found")
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                self.stars = result.stars ?? ["Unknown"]
                completion(result)
            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
        }
        task.resume()
    }
}
