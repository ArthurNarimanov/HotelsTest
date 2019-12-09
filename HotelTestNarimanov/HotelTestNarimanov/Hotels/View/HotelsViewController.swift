//
//  ViewController.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit

class HotelsViewController: UIViewController {
	var presenter: HotelViewPresenterProtocol! 
	private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
	private let tableView = UITableView()
	private let headerView = UIView()
	private let segmentedControl = UISegmentedControl(items: ["All", "Distance", "Suites Count"])
	
	//MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.getHotels()
		setupView()
		setHiddenTableView(isHide: true)
	}
}
// MARK: -  UITableViewDelegate, UITableViewDataSource
extension HotelsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.filterData?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HotelTableViewCell.name, for: indexPath) as! HotelTableViewCell
		guard let model = presenter.filterData?[indexPath.row] else { return cell }
		cell.set(model: model)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 96
	}
	
	// MARK: Header Table View
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let id = presenter.filterData?[indexPath.row].id else { return }
		let hotelDetailViewController = ViewBuilder.createHotelDetailViewBuilder(id: id)
		navigationController?.pushViewController(hotelDetailViewController, animated: true) 
	}
}
// MARK: - HotelViewProtocol
extension HotelsViewController: HotelViewProtocol {
	func setHotels() {
		tableView.reloadData()
		setHiddenTableView(isHide: false)
		activityIndicator.stopAnimating()
	}
}
// MARK: - private setup view
fileprivate extension HotelsViewController {
	
	private func setHiddenTableView(isHide: Bool) {
		tableView.isHidden = isHide
	}
	private func setupView() {
		setupNavigstionController()
		setupActivityIndicator()
		setupTableView()
		setupHeaderView()
		setupSegmentControll()
	}
	
	private func setupNavigstionController() {
		self.navigationItem.title = "Hotels"
	}
	
	private func setupActivityIndicator() {
		activityIndicator.translatesAutoresizingMaskIntoConstraints = true
		activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		activityIndicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
		
		activityIndicator.hidesWhenStopped = true
		activityIndicator.startAnimating()
		activityIndicator.color = .white
		
		self.view.addSubview(activityIndicator)
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: HotelTableViewCell.name)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(tableView)
		
		 NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}
	
	private func setupHeaderView() {
		headerView.translatesAutoresizingMaskIntoConstraints = true
		headerView.backgroundColor = .systemYellow
	}
	
	private func setupSegmentControll() {
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.addTarget(self, action: #selector(handleSegmentController(_:)), for: .valueChanged)
		
		headerView.addSubview(segmentedControl)
		NSLayoutConstraint.activate([
			segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
			segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
			segmentedControl.heightAnchor.constraint(equalToConstant: 24)
		])
	}
	
	@objc private func handleSegmentController(_ sender: UISegmentedControl) {
		presenter.filterHotel(segmentIndex: sender.selectedSegmentIndex) { result in
			switch result {
			case .success:
				tableView.reloadData()
			case .failure:
				break
			}
		}
	}
}

