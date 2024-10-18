import UIKit

final class MainViewModel {
    
    private let urlString: String = APIConstants.baseURL + "?page=1"
    private(set) var movies: [MovieResult] = []

    func fetchTrendingMovies(completion: @escaping () -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("get-trending-movies", forHTTPHeaderField: "Type")
        request.addValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(APIConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("No data found")
                return
            }

            do {
                let result = try JSONDecoder().decode(TrendMovieData.self, from: data)
                self.movies = result.movieResults
                completion()
            } catch {
                print("JSON parsing error:", error)
            }
        }
        task.resume()
    }
}
