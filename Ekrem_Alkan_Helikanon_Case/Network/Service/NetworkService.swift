//
//  NetworkService.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Alamofire

protocol CategoryService: AnyObject {
    func getMovies(categoryType: NetworkConstants, onSuccess: @escaping (MovieModel?) -> Void, onError: @escaping (AFError) -> Void)
}

protocol DetailService: AnyObject {
    func getMovieDetails(with movieID: String, onSuccess: @escaping (DetailModel?) -> Void, onError: @escaping (AFError) -> Void)
    func getVideoDetails(with movieID: String, onSuccess: @escaping (VideoModel?) -> Void, onError: @escaping (AFError) -> Void)
    func getCastsDetails(with movieID: String, onSuccess: @escaping (CastModel?) -> Void, onError: @escaping (AFError) -> Void)
}

final class NetworkService {
    
}

//MARK: - Getting Categories
extension NetworkService: CategoryService {
    func getMovies(categoryType: NetworkConstants, onSuccess: @escaping (MovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        let endPoint = NetworkEndPointCases.getPopularMovies(categoryType: .popular)
        
        NetworkManager.shared.request(path: endPoint.path, headers: endPoint.headers, bearerToken: endPoint.apiKey) { model in
            onSuccess(model)
        } onError: { error in
            onError(error)
        }

    }
  
    
}

//MARK: - Getting Details
extension NetworkService: DetailService {
    func getMovieDetails(with movieID: String, onSuccess: @escaping (DetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        let endPoint = NetworkEndPointCases.getDetails(categoryType: .detail, movieID: movieID)
        
        NetworkManager.shared.request(path: endPoint.path, headers: endPoint.headers, bearerToken: endPoint.apiKey) { model in
            onSuccess(model)
        } onError: { error in
            onError(error)
        }

    }
    
    
    func getVideoDetails(with movieID: String, onSuccess: @escaping (VideoModel?) -> Void, onError: @escaping (AFError) -> Void) {
        let endPoint = NetworkEndPointCases.getVideos(categoryType: .detail, movieID: movieID)
        
        NetworkManager.shared.request(path: endPoint.path, headers: endPoint.headers, bearerToken: endPoint.apiKey) { model in
            onSuccess(model)
        } onError: { error in
            onError(error)
        }

    }
    
    func getCastsDetails(with movieID: String, onSuccess: @escaping (CastModel?) -> Void, onError: @escaping (AFError) -> Void) {
        let endPoint = NetworkEndPointCases.getCasts(categoryType: .detail, movieID: movieID)
        print(endPoint.path)
        
        NetworkManager.shared.request(path: endPoint.path, headers: endPoint.headers, bearerToken: endPoint.apiKey) { model in
            onSuccess(model)
        } onError: { error in
            onError(error)
        }

    }
   
    
    
}

