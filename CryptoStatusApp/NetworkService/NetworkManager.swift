//
//  NetworkManager.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

 import Foundation

 protocol CryptoNetworkManagerProtocol {
     func fetchDataModelType<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<T, Error>) -> Void)
 }

 class CryptoNetworkManager: CryptoNetworkManagerProtocol {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

     func fetchDataModelType<T: Codable>(endpoint: EndpointProtocol, modelType: T.Type, complition: @escaping (Swift.Result<T, Error>) -> Void) {

         print("Task starts")

         guard let request = endpoint.makeURLRequest(method: .GET) else {
            return
        }

         session.dataTask(with: request) { data, response, error in
             var result: Swift.Result<T, Error>

             defer {
                 DispatchQueue.main.async {
                     print("WTF???!!")
                     complition(result)
                 }
             }

             if error == nil, let parsData = data {
                 do {
                     let resultOfRequest = try JSONDecoder().decode(modelType.self, from: parsData)
                     print("success??")
                     result = .success(resultOfRequest)
                 } catch {
                     guard let resp = response as? HTTPURLResponse else {
                         print("response is not HTTPURLResponse")
                         result = .failure(ErrorNetwork.wrongResponse)
                         return
                     }
                     print("response statusCode: \(String(resp.statusCode))")
                     switch resp.statusCode {
                     case 200..<300:
                         print("+++++ STAtu code")
                         result = .failure(ErrorNetwork.wrongFormatJSON)
                     default:
                         result = .failure(ErrorNetwork.dataNotFound)
                     }
                 }
             } else {
                 result = .failure(ErrorNetwork.connectingProblem)
             }
         }
         .resume()
    }
 }
