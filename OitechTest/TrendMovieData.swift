import Foundation

// MARK: - TrendMovieData
struct TrendMovieData: Codable {
    let movieResults: [MovieResult]
    let results: Int
    let totalResults, status, statusMessage: String

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case results
        case totalResults = "Total_results"
        case status
        case statusMessage = "status_message"
    }
}

// MARK: - MovieResult
struct MovieResult: Codable {
    let title, year, imdbID: String

    enum CodingKeys: String, CodingKey {
        case title, year
        case imdbID = "imdb_id"
    }
}
