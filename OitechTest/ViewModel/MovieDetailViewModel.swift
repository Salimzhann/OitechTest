//
//  MovieDetailViewModel.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 18.10.2024.
//

import UIKit

final class MovieDetailViewModel {
    
    private let URLString: String = APIConstants.baseURL
    
    func fetchData(id: String, completion: @escaping () -> Void) {
        guard let url = URL(string: URLString + "?\(id)") else {
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
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response type: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("something wrong with data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion()
            } catch {
                print("Something went wrong in Decode:", error)
            }
        }
        task.resume()
    }
}
