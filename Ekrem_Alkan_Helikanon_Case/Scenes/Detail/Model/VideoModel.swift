//
//  VideoModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

// MARK: - VideoModel
struct VideoModel: Codable {
    let id: Int?
    let results: [Video]?
}

// MARK: - Result
struct Video: Codable {
    let name, key: String?
    let size: Int?
    let official: Bool?
    let publishedAt, id: String?

}

