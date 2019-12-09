//
//  NameProtocol.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 01/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit.UINib

protocol NameProtocol: class {
	static var name: String { get }
	static var nib: UINib { get }
}
extension NameProtocol {
	static var name: String {
        return String(describing: self)
    }
	static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
}
