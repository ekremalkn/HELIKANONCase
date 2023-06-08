//
//  MovieModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Foundation

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movies
struct Result: Codable, HomeCollectionCellDataProtocol, HeaderCollectionCellDataProtocol {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    //MARK: - HomeCollectionCellDataProtocol
    var homeCCImage: String {
        if let posterPath {
            return posterPath
        }
        return "" // add placeHolderImage
    }
    
    var homeCCTitle: String {
        if let title {
            return title
        }
        return "Title did'nt find"
    }
    
    var homeCCRating: String {
        if let voteAverage {
            return "\(voteAverage) / 10 IMDB"
        }
        return "Did'nt find"
    }
    
    var homeCCgenres: [Int] {
        if let genreIDS {
            return genreIDS
        }
        return []
    }
    
    //MARK: - HeaderCollectionCellDataProtocol
    var headerCCImage: String {
        if let posterPath {
            return posterPath
        }
        return "" // add placeHolderImage
    }
    
    var headerCCTitle: String {
        if let title {
            return title
        }
        return "Title did'nt find"
    }
    
    var headerCCRating: String {
        if let voteAverage {
            return "\(voteAverage) / 10 IMDB"
        }
        return "Did'nt find'"
    }
    
}

