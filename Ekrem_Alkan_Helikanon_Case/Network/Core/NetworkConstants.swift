//
//  NetworkConstants.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Foundation

protocol NetworkConstantsProtocol {
    var baseRequestURL: String { get }
}

public enum NetworkConstants: NetworkConstantsProtocol {
    case popular
    case trends
    case detail
    
    var baseRequestURL: String {
        switch self {
        case .popular:
           return "https://api.themoviedb.org/3/movie/popular"
        case .trends:
            return "https://api.themoviedb.org/3/movie/top_rated"
        case .detail:
            return "https://api.themoviedb.org/3/movie/"
        }
    }
}
