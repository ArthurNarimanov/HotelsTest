//
//  HotelDetailViewController.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit

class HotelDetailViewController: UIViewController {
	@IBOutlet private weak var pictureView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var addressLabel: UILabel!
	@IBOutlet private weak var distanceLabel: UILabel!
	@IBOutlet private weak var distanceValueLabel: UILabel!
	@IBOutlet private weak var suitesLabel: UILabel!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet private weak var starsStackView: UIStackView!
	
	var presenter: HotelDetailViewPresenterProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.setHotelNetwork()
		setupStarsStackView()
	}
}

extension HotelDetailViewController: HotelDetailViewProtocol {
	func imageError() {
		pictureView.image = UIImage(named: "notImage")
		activityIndicator.stopAnimating()
	}
	
	func setHotel() {
		guard let hotel = presenter.hotel else { return }
		let star = Int(hotel.stars ?? 0.0)
		let distanceStr = String(hotel.distance ?? 0.0)
		setupStarsSteckView(starCount: star)
		nameLabel.text = hotel.name
		addressLabel.text = hotel.address
		distanceValueLabel.text = distanceStr
		suitesLabel.text = hotel.suites_availability
	}
	
	func setImage() {
		guard let hotel = presenter.hotel,
			let data = hotel.imageData,
			let image = UIImage(data: data),
			let imageCrop = CropImage.cut(image) else { imageError(); return }
		
		pictureView.image = imageCrop
		activityIndicator.stopAnimating()
	}
}

fileprivate extension HotelDetailViewController {
	//MARK: setup Stars Stack
	private func setupStarsStackView() {
		starsStackView.translatesAutoresizingMaskIntoConstraints = false
		starsStackView.spacing = 6
		starsStackView.isUserInteractionEnabled = false
		
		self.view.addSubview(starsStackView)
		
		NSLayoutConstraint.activate([
			starsStackView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 16),
			starsStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
			starsStackView.heightAnchor.constraint(equalToConstant: 16)
		])
	}
	private func setupStarsSteckView(starCount: Int){
		guard starCount > 0  else {
			starsStackView.isHidden = true
			return
		}
		addStarToStarsStackView(by: starCount)
	}
	
	private func addStarToStarsStackView(by starCount: Int) {
		let maxStar: Int = 5
		
		for _ in 0 ..< starCount {
			guard starCount <= maxStar else { return }
			let starImageView = UIImageView()
			
			starImageView.translatesAutoresizingMaskIntoConstraints = false
			starImageView.contentMode = .scaleAspectFit
			starImageView.backgroundColor = .clear
			
			starImageView.image = UIImage(named: "star")
			starsStackView.addArrangedSubview(starImageView)
		}
	}
}

