//
//  HotelModelView.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

protocol HotelModelViewProtocol {
	var id: Int { get }
	var name: String? { get }
	var address: String? { get }
	var stars: Float? { get }
	var distance: Float? { get }
	var suites_availability: String? { get }
	var suitesCount : Int { get }
}
extension HotelModelViewProtocol {
	var suitesCount: Int {
		guard let suites = suites_availability else { return 0 }
		
		var arraySuites = suites.components(separatedBy: ":")
		arraySuites.removeAll { $0 == ""}
		
		return Set(arraySuites).count
	}
}

struct HotelModelView: HotelModelViewProtocol {
	let id: Int
	let name: String?
	let address: String?
	let stars: Float?
	let distance: Float?
	let suites_availability: String?
}


