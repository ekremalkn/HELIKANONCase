//
//  NetworkEndPointCases.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Alamofire

public enum NetworkEndPointCases: NetworkEndPoint {
    
    case getMovies(categoryType: NetworkConstants)
    case getDetails(categoryType: NetworkConstants, movieID: String)
    case getVideos(categoryType: NetworkConstants, movieID: String)
    case getCasts(categoryType: NetworkConstants, movieID: String)
    
    var apiKey: String {
        NetworkAPIConstants.API_KEY.rawValue
    }
    
    var path: String {
        switch self {
        case .getMovies(categoryType: let categoryType):
            return categoryType.baseRequestURL
        case .getDetails(categoryType: let categoryType, movieID: let movieID):
            return "\(categoryType.baseRequestURL)\(movieID)"
        case .getVideos(categoryType: let categoryType, movieID: let movieID):
            return "\(categoryType.baseRequestURL)\(movieID)/videos"
        case .getCasts(categoryType: let categoryType, movieID: let movieID):
            return "\(categoryType.baseRequestURL)\(movieID)/credits"
        }
    }
    
    var headers: HTTPHeaders {
        [
            "Authorization": "Bearer \(NetworkAPIConstants.API_KEY.rawValue)"
        ]
    }
    
    
}
