//
//  NetworkManager.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//
//https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation

enum NetworkResponce: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case checkNetConnection = "Please check your network connection."
}
enum Result<String> {
    case success
    case failure(String)
}
protocol NetworkServiceProtocol {
	func getHotels(completion: @escaping ([HotelModelViewProtocol]) -> Void)
	func getHotel(id: Int, completion: @escaping (HotelDetailViewModelProtocol?) -> Void)
	func getImage(id: String, completion: @escaping (Data?) -> Void)
}
struct NetworkManager: NetworkServiceProtocol {
	
	static let environment: NetworkEnvironment = .production
    private let router = Router<HotelAPI>()
	
	fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200 ... 299: return .success
        case 400 ... 500: return .failure(NetworkResponce.authenticationError.rawValue)
        case 501 ... 599: return .failure(NetworkResponce.badRequest.rawValue)
        case 600: return .failure(NetworkResponce.outdated.rawValue)
        default: return .failure(NetworkResponce.failed.rawValue)
			
        }
    }
	
	func getHotels(completion: @escaping ([HotelModelViewProtocol]) -> Void) {
		router.request(.getHotels(json: "0777.json")) { (data, response, error) in
			if error != nil {
                completion([])
            }
			if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion([])
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode([HotelModel].self, from: responseData)
                            completion(apiResponse)
                        } catch {
                            completion([])
                        }
                    case .failure:
                        completion([])
                    }
                }
            }
		}
	}
	
	func getHotel(id: Int, completion: @escaping (HotelDetailViewModelProtocol?) -> Void) {
		router.request(.getHotel(id: id)) { (data, response, error) in
			if error != nil {
                completion(nil)
            }
			if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                             completion(nil)
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode(HotelDescriptionModel.self, from: responseData)
                            completion(apiResponse)
                        } catch {
							completion(nil)
                        }
                    case .failure:
						 completion(nil)
                    }
                }
            }
		}
	}
	
	func getImage(id: String, completion: @escaping (Data?) -> Void) {
		router.request(.getImage(id: id)) { (data, response, error) in
			if error != nil {
                completion(nil)
            }
			if let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else { completion(nil); return }
						 completion(responseData)
						
                    case .failure:
						 completion(nil)
                    }
                }
            }
		}
	}
}
