//
//  DetailsCollectionViewCell.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 28/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

struct DetailsCollectionViewCellViewModel {
	let placeholder: String
	let text: String
}

class DetailsCollectionViewCell: UICollectionViewCell {

	// MARK: - Constant

	static let identifier = "DetailsCollectionViewCell"

	private enum Constant {
		static let animationDuration = 0.25

		enum Font {
			enum Label {
				static let placeholder = UIFont(name: "HelveticaNeue-Bold", size: UIDevice.isIpad ? 24: 12)
				static let text = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 48: 24)
			}
		}
	}

	// MARK: - IBOutlet

	@IBOutlet weak var placeholderLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var gradientView: UIView!

	// MARK: - Public

	override func awakeFromNib() {
		super.awakeFromNib()
		setupUI()
	}

	func configure(viewModel: DetailsCollectionViewCellViewModel) {
		placeholderLabel.text = viewModel.placeholder
		nameLabel.text = viewModel.text
	}

	static var nib: UINib {
		return UINib(nibName: DetailsCollectionViewCell.identifier, bundle: nil)
	}

	// MARK: - Private

	private func setupUI() {
		placeholderLabel.textColor = .appYellow
		placeholderLabel.font = Constant.Font.Label.placeholder

		nameLabel.textColor = .appWhite
		nameLabel.font = Constant.Font.Label.text

		gradientView.backgroundColor = .appBlack
		gradientView.alpha = 0.25

		backgroundColor = .clear
		contentView.backgroundColor = .clear
	}
}
