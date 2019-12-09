//
//  HotelsPresenter.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

enum ResultFilter {
	case success
	case failure
}

protocol HotelViewProtocol: class {
	func setHotels()
}
protocol HotelViewPresenterProtocol: class {
	init(view: HotelViewProtocol, networkService: NetworkServiceProtocol)
	var hotelsView: [HotelModelViewProtocol]? { get set }
	var filterData: [HotelModelViewProtocol]? { get set }
	func getHotels()
	func filterHotel(segmentIndex: Int, completion: (ResultFilter)-> Void)
}

class HotelsPresenter: HotelViewPresenterProtocol {
	var hotelsView: [HotelModelViewProtocol]?
	var filterData: [HotelModelViewProtocol]?
	weak var view: HotelViewProtocol?
	let networkService: NetworkServiceProtocol!
	
	required init(view: HotelViewProtocol, networkService: NetworkServiceProtocol) {
		self.view = view
		self.networkService = networkService
	}
	
	func getHotels() {
		networkService.getHotels { [weak self] hotels in
			guard !hotels.isEmpty, let _self = self else { return }
			
			_self.hotelsView = hotels
			_self.filterData = hotels
			_self.view?.setHotels()
		}
	}
	
	func filterHotel(segmentIndex: Int, completion: (ResultFilter)-> Void) {
		guard let hotelsView = hotelsView else { completion(.failure); return }
		switch segmentIndex {
		case 0:
			filterData = hotelsView
			completion(.success)
			
		case 1:
			filterData = hotelsView.sorted(by: { (first, second) -> Bool in
				guard let first = first.distance,  let second = second.distance else { return false }
				return first < second
			})
			completion(.success)
			
		case 2:
			filterData = hotelsView.sorted(by: { (first, second) -> Bool in
				return first.suitesCount > second.suitesCount
			})
			completion(.success)
			
		default:
			filterData = hotelsView
			completion(.failure)
		}
	}
}
