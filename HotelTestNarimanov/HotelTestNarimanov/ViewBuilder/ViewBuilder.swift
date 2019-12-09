//
//  MainViewBuilder.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit.UIViewController

protocol Builder {
	static func createHotelsViewBuilder() -> UIViewController
	static func createHotelDetailViewBuilder(id: Int) -> UIViewController
}

class ViewBuilder: Builder {
	static func createHotelsViewBuilder() -> UIViewController {
		let view = HotelsViewController()
		let networkService = NetworkManager()
		let presenter = HotelsPresenter(view: view, networkService: networkService)
		view.presenter = presenter
		
		return view
	}
	
	static func createHotelDetailViewBuilder(id: Int) -> UIViewController {
		let view = HotelDetailViewController()
		let networkService = NetworkManager()
		let presenter = HotelDetailViewPresenter(view: view, networkService: networkService, id: id)
		view.presenter = presenter
		
		return view
	}
}
