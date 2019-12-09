//
//  HotelModel.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

struct HotelModel: Decodable, HotelModelViewProtocol {
	let id: Int
	let name: String?
	let address: String?
	let stars: Float?
	let distance: Float?
	let suites_availability: String?
}
