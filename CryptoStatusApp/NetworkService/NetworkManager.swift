//
//  NetworkManager.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

 import Foundation

 protocol CryptoNetworkManagerProtocol {
     func fetchDataModelType<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<Codable, Error>) -> Void)
 }

 enum ObtainResults {
    case success(result: [Codable])
    case failure(error: Error)
 }

 class CryptoNetworkManager: CryptoNetworkManagerProtocol {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

     func fetchDataModelType<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<Codable, Error>) -> Void) {

         guard let request = endpoint.makeURLRequest(method: .GET) else {
            return
        }

         session.dataTask(with: request) { data, response, error in
             var result: Swift.Result<Codable, Error>

             defer {
                 DispatchQueue.main.async {
                     complition(result)
                 }
             }

             if error == nil, let parsData = data {
                 do {
                     let resultOfRequest = try JSONDecoder().decode(modelType.self, from: parsData)
                     print("Получена модель \(modelType)")
                     result = .success(resultOfRequest)
                 } catch {
                     guard let resp = response as? HTTPURLResponse else {
                         print("response is not HTTPURLResponse")
                         result = .failure(error)
                         return
                     }
                     print("response statusCode: \(String(resp.statusCode))")
                     result = .failure(error)
                 }
             } else {
                 result = .failure(error!)
             }
         }
         .resume()
    }
 }
