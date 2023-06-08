//
//  CastModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

// MARK: - Model
struct CastModel: Codable {
    let id: Int?
    let cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable, CastCollectionCellDataProtocol {
    let adult: Bool?
    let gender, id: Int?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
    }
    
    var castCCActorImage: String {
        if let profilePath {
            return profilePath
        }
        return ""
    }
    
    var castCCActorName: String {
        if let originalName {
            return originalName
        }
        return "Unkown Actor"
    }
    
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
