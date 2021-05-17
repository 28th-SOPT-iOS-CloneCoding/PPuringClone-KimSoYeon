//
//  MovieModel.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let adult: Bool
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
