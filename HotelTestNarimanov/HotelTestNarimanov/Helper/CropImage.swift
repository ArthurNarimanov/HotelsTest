//
//  CropImage.swift
//  HotelTestNarimanov
//
//  Created by Arthur Narimanov on 02/12/2019.
//  Copyright © 2019 Arthur Narimanov. All rights reserved.
//

import UIKit.UIImage

struct CropImage {
	static func cut(_ inputImage: UIImage, viewWidth: CGFloat = 1, viewHeight: CGFloat = 1) -> UIImage? {
		let firstBoundingBox: CGRect =  CGRect(x: viewWidth, y: viewHeight,
											   width: inputImage.size.width - viewWidth * 2,
											   height: inputImage.size.height - viewHeight * 2)
		
		guard let imageCut = inputImage.cropped(boundingBox: firstBoundingBox) else { return nil }
		
		return imageCut
	}
}
