//
//  HotelAPI.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}
public enum HotelAPI {
	case getHotels(json: String)
	case getHotel(id: Int)
	case getImage(id: String)
}

extension HotelAPI: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production:
            var components = URLComponents()
            components.scheme = "https"
            components.host = "raw.githubusercontent.com"
            return components.string!
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
		case .getHotels(let json):
			return "/iMofas/ios-android-test/master/\(json)"
		case .getHotel(let id):
			return "/iMofas/ios-android-test/master/\(id).json"
		case .getImage(let id):
			return "/iMofas/ios-android-test/master/\(id)"
		}
    }
    
    var httpMethod: HTTPMethod {
        switch self {
		case .getHotels:
			return .get
		case .getHotel:
			return .get
		case .getImage:
			return .get
		}
    }
    
    var task: HTTPTask {
        switch self {
		case .getHotels:
			return .request
		case .getHotel:
			return .request
		case .getImage:
			return .request
		}
    }
    
    var headers: HTTPHeaders? {
        switch self {
		case .getHotels:
			return nil
		case .getHotel:
			return nil
		case .getImage:
			return nil
		}
    }
}

