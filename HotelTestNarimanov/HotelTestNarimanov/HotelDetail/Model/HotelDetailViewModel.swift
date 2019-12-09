//
//  HotelDetailViewModel.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

protocol HotelDetailViewModelProtocol {
	var id: Int { get }
	var name: String? { get }
	var address: String? { get }
	var stars: Float? { get }
	var distance: Float? { get }
	var image: String? { get }
	var suites_availability: String? { get }
	var imageData: Data? { get set }
}


struct HotelDetailViewModel: HotelDetailViewModelProtocol {
	let id: Int
	let name: String?
	let address: String?
	let stars: Float?
	let distance: Float?
	let image: String?
	let suites_availability: String?
	var imageData: Data?
}
