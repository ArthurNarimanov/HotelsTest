//
//  HotelTableViewCell.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell, NameProtocol {
	
	private let titleLabel = UILabel()
	private let subtiltleLabel = UILabel()
	private let distanceLabel = UILabel()
	private let distanceDescriptionLabel = UILabel()
	private let suitesLabel = UILabel()
	private let suitesCountLabel = UILabel()
	private let starsStackView = UIStackView()
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: HotelTableViewCell.name)
		setupViewCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	override func prepareForReuse() {
		titleLabel.text = nil
		subtiltleLabel.text = nil
		distanceDescriptionLabel.text = nil
		suitesCountLabel.text = nil
		starsStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
	}
	
	func set(model: HotelModelViewProtocol) {
		titleLabel.text = model.name
		subtiltleLabel.text = model.address
		let distanceStr = String(model.distance ?? 0.0)
		distanceDescriptionLabel.text = distanceStr
		suitesCountLabel.text = String(model.suitesCount)
		
		let stars = Int(model.stars ?? 0.0)
		setupStarsStackView(starCount: stars)
	}
}

fileprivate extension HotelTableViewCell {
	
	private func setupViewCell() {
		setupTitleLabel()
		setupSubtitleLabel()
		setupDistancelabel()
		setupDistanceDescriptionLabel()
		setupSuitesAvailabilityLabell()
		setupSuitesCountLabel()
		setupStarsStackView()
	}
	
	private func setupTitleLabel() {
	
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.font = UIFont.systemFont(ofSize: 16)
		titleLabel.textAlignment = .left
		
		self.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			titleLabel.heightAnchor.constraint(equalToConstant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
		])
	}
	
	private func setupSubtitleLabel() {
		
		subtiltleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtiltleLabel.font = UIFont.systemFont(ofSize: 12)
		subtiltleLabel.textAlignment = .left
		
		self.addSubview(subtiltleLabel)
		
		NSLayoutConstraint.activate([
			subtiltleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			subtiltleLabel.heightAnchor.constraint(equalToConstant: 14),
			subtiltleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			subtiltleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
		])
	}
	
	private func setupDistancelabel() {
		
		distanceLabel.translatesAutoresizingMaskIntoConstraints = false
		distanceLabel.text = "Distance:"
		distanceLabel.font = UIFont.systemFont(ofSize: 12)
		distanceLabel.textAlignment = .left
		
		self.addSubview(distanceLabel)
		
		NSLayoutConstraint.activate([
			distanceLabel.topAnchor.constraint(equalTo: subtiltleLabel.bottomAnchor, constant: 4),
			distanceLabel.heightAnchor.constraint(equalToConstant: 14),
			distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
		])
	}
	
	private func setupDistanceDescriptionLabel() {
		distanceDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		distanceDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
		distanceDescriptionLabel.textAlignment = .left
		
		self.addSubview(distanceDescriptionLabel)
		
		NSLayoutConstraint.activate([
			distanceDescriptionLabel.topAnchor.constraint(equalTo: distanceLabel.topAnchor),
			distanceDescriptionLabel.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 4),
			distanceDescriptionLabel.heightAnchor.constraint(equalToConstant: 14),
			distanceDescriptionLabel.widthAnchor.constraint(equalToConstant: 44)
		])
	}
	
	private func setupSuitesAvailabilityLabell() {
		suitesLabel.translatesAutoresizingMaskIntoConstraints = false
		suitesLabel.text = "Suites:"
		suitesLabel.font = UIFont.systemFont(ofSize: 12)
		suitesLabel.textAlignment = .left
		
		self.addSubview(suitesLabel)
		
		NSLayoutConstraint.activate([
			suitesLabel.topAnchor.constraint(equalTo: distanceDescriptionLabel.topAnchor),
			suitesLabel.heightAnchor.constraint(equalToConstant: 14),
			suitesLabel.leadingAnchor.constraint(equalTo: distanceDescriptionLabel.trailingAnchor, constant: 8)
		])
	}
	
	private func setupSuitesCountLabel() {
		suitesCountLabel.translatesAutoresizingMaskIntoConstraints = false
		suitesCountLabel.font = UIFont.systemFont(ofSize: 12)
		suitesCountLabel.textAlignment = .left
		
		self.addSubview(suitesCountLabel)
		
		NSLayoutConstraint.activate([
			suitesCountLabel.topAnchor.constraint(equalTo: suitesLabel.topAnchor),
			suitesCountLabel.leadingAnchor.constraint(equalTo: suitesLabel.trailingAnchor, constant: 4),
			suitesCountLabel.heightAnchor.constraint(equalToConstant: 14),
			suitesCountLabel.widthAnchor.constraint(equalToConstant: 44),
		])
	}
	private func setupStarsStackView() {
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        starsStackView.spacing = 6
        starsStackView.isUserInteractionEnabled = false
		
		self.addSubview(starsStackView)
		
		NSLayoutConstraint.activate([
			starsStackView.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8),
			starsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			starsStackView.heightAnchor.constraint(equalToConstant: 16)
		])
	}
	
	private func setupStarsStackView(starCount: Int){
        guard starCount > 0  else { return }
        addStarToStarsStackView(by: starCount)
    }
    
    private func addStarToStarsStackView(by starCount: Int, maxStar: Int = 5) {
		guard starsStackView.arrangedSubviews.count <= starCount else { return }
        for _ in 0 ..< starCount {
            guard starCount < maxStar else { return }
            let starImageView = UIImageView()
            
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.contentMode = .scaleAspectFill
            starImageView.backgroundColor = .clear
            
            starImageView.image = UIImage(named: "star")
            starsStackView.addArrangedSubview(starImageView)
        }
    }
}
