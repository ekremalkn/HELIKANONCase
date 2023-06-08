//
//  NetworkManager.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Alamofire

public final class NetworkManager {
    static let shared = NetworkManager()
    
    public func request<T:Decodable>(path: String, headers: HTTPHeaders, bearerToken: String, onSuccess: @escaping (T) -> Void, onError: @escaping (AFError) -> Void) {
        AF.request(path, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                let result = response.result
                
                switch result {
                case .success(let model):
                    onSuccess(model)
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
