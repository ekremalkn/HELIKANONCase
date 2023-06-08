//
//  DetailModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

// MARK: - DetailModel
struct DetailModel: Codable, DetailViewDataProtocol {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var dvMovieTitle: String {
        if let title {
            return title
        }
        return "Did not find"
    }
    
    var dvRating: String {
        if let voteAverage {
            return "\(voteAverage.roundToDecimal(places: 2)) / 10 IMDB"
        }
        return "Did'nt find"
    }
    
    var dvGenreIDs: [Int] {
        if let genres {
            return genres.map { $0.id ?? 0 }
        }
        return []
    }
    
    var dvRelease: String {
        if let releaseDate {
            return releaseDate
        }
        return "Unkown"
    }
    
    var dvLanguage: String {
        if let originalLanguage {
            return originalLanguage
        }
        return "Unknown"
    }
    
    var dvVoteCount: String {
        if let voteCount {
            return "\(voteCount)"
        }
        return "Unkown"
    }
    
    var dvDescription: String {
        if let overview {
            return overview
        }
        return "Unkown"
    }
    
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

