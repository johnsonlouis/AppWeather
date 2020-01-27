//
//  ImageLoader.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 27/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import Kingfisher

enum ImageLoaderError: Error, Equatable {
	case nilOrEmpty
	case badRequest(String?)
}

protocol ImageLoaderProtocol {
	static func loadImage<T: UIImageView>(imageView: T, imageUrlString: String?, placeholder: UIImage?, completionHandler: @escaping (Result<UIImage, Error>) -> Void?)
}

enum ImageLoader<T>: ImageLoaderProtocol {
	static func loadImage<T: UIImageView>(imageView: T, imageUrlString: String?, placeholder: UIImage?, completionHandler: @escaping (Result<UIImage, Error>) -> Void?) {
		guard let imageUrlString = imageUrlString,
			!imageUrlString.isEmpty else {
				completionHandler(.failure(ImageLoaderError.nilOrEmpty))
				return
		}
		guard let url = URL(string: imageUrlString) else {
			completionHandler(.failure(ImageLoaderError.badRequest(imageUrlString)))
			return
		}
		imageView.kf.indicatorType = .activity
		imageView.kf.setImage(with: ImageResource(downloadURL: url),
							  placeholder: placeholder,
							  options: [.transition(.fade(0.2))],
							  progressBlock: nil) { result in
								switch result {
								case .success(let image):
									completionHandler(.success(image.image))
								case .failure(let error):
									completionHandler(.failure(error))
								}
		}
	}
}
