//
//  UIImageView+ImageLoader.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

extension UIImageView {

	func load(with imageUrlString: String?, placeholder: UIImage? = nil, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
		ImageLoader<UIImageView>.loadImage(imageView: self,
										   imageUrlString: imageUrlString,
										   placeholder: placeholder,
										   completionHandler: completionHandler)
	}
}
