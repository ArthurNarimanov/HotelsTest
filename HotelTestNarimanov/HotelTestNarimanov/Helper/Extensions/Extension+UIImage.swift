//
//  Extension+UIImage.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 02/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
	func cropped(boundingBox: CGRect) -> UIImage? {
		guard let cgImage = self.cgImage?.cropping(to: boundingBox) else { return nil }
		
		return UIImage(cgImage: cgImage)
	}
}
