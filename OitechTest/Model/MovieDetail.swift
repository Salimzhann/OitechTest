struct MovieDetail: Codable {
    let title: String
    let description: String
    let tagline: String
    let year: String
    let releaseDate: String
    let imdbRating: String
    let genres: [String]
    let stars: [String]
    let directors: [String]
    let countries: [String]
    let language: [String]

    enum CodingKeys: String, CodingKey {
        case title, description, tagline, year
        case releaseDate = "release_date"
        case imdbRating = "imdb_rating"
        case genres, stars, directors, countries, language
    }
}
