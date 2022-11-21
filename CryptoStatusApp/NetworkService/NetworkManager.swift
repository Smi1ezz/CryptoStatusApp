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

        guard let request = endpoint.makeURLRequest(method: .GET) else {
            return
        }

        session.dataTask(with: request) { data, response, error in
            var result: Swift.Result<T, Error>

            defer {
                DispatchQueue.main.async {
                    complition(result)
                }
            }

            guard error == nil else {
                result = .failure(ErrorNetwork.connectingProblem)
                return
            }

            guard let parsData = data else {
                result = .failure(ErrorNetwork.dataNotFound)
                return
            }

            guard let resp = response as? HTTPURLResponse else {
                result = .failure(ErrorNetwork.wrongResponse)
                return
            }

            print("response statusCode: \(String(resp.statusCode))")
            switch resp.statusCode {
            case 200..<300:
                do {
                    let resultOfRequest = try JSONDecoder().decode(modelType.self, from: parsData)
                    result = .success(resultOfRequest)
                } catch {
                    result = .failure(ErrorNetwork.wrongFormatJSON)
                }

            default:
                result = .failure(ErrorNetwork.wrongStatusCode)
            }
        }
        .resume()
    }
}
