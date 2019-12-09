//
//  HotelDetail.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import Foundation

protocol HotelDetailViewProtocol: class {
	func setHotel()
	func setImage()
	func imageError()
}

protocol HotelDetailViewPresenterProtocol: class {
	init(view: HotelDetailViewProtocol, networkService: NetworkServiceProtocol, id: Int)
	func setHotelNetwork()
	var hotel: HotelDetailViewModelProtocol? { get set }
}

class HotelDetailViewPresenter: HotelDetailViewPresenterProtocol {
	weak var view: HotelDetailViewProtocol!
	let networkService: NetworkServiceProtocol!
	let id: Int!
	var hotel: HotelDetailViewModelProtocol?
	
	required init(view: HotelDetailViewProtocol, networkService: NetworkServiceProtocol, id: Int) {
		self.view = view
		self.networkService = networkService
		self.id = id
	}
	
	func setHotelNetwork() {
		self.networkService.getHotel(id: id) { [weak self] hotel in
			guard let hotel = hotel, let _self = self else { return }
			_self.hotel = hotel
			_self.view.setHotel()
			guard let imageStr = _self.hotel?.image else { _self.view.imageError(); return }
			_self.setImage(id: imageStr)
		}
	}
	
	private func setImage(id: String) {
		self.networkService.getImage(id: id) { [weak self] data in
			guard let data = data, let _self = self else { self?.view.imageError(); return }
			_self.hotel?.imageData = data
			_self.view.setImage()
		}
	}
}
