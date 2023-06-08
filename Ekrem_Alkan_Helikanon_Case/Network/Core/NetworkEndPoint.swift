//
//  NetworkEndPoint.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Alamofire

protocol NetworkEndPoint {
    var apiKey: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
}
