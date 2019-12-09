//
//  HotelDescriptionModel.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

struct HotelDescriptionModel: Decodable, HotelDetailViewModelProtocol {
	let id: Int
    let name: String?
    let address: String?
    let stars: Float?
    let distance: Float?
    let image: String?
    let suites_availability: String?
    let lat: Double?
    let lon: Double?
	var imageData: Data?
}
