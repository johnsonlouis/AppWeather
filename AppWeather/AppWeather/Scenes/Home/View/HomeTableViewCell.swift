//
//  HomeTableViewCell.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 26/01/2020.
//  Copyright © 2020 Johnson-Richie Louis. All rights reserved.
//

import UIKit

struct HomeTableViewCellViewModel {
	let name: String
	let imageUrl: String?
	let max: String
	let min: String
}

class HomeTableViewCell: UITableViewCell {

	// MARK: - Constant

	static let identifier = "HomeTableViewCell"

	private enum Constant {
		enum Font {
			static let dayLabel = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 30: 18)
			static let maxLabel = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 30: 18)
			static let minLabel = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 30: 18)
		}
	}

	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var maxLabel: UILabel!
	@IBOutlet weak var minLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		setupUI()
	}

	// MARK: - Public

	static var nib: UINib {
		return UINib(nibName: HomeTableViewCell.identifier, bundle: nil)
	}

	func configure(viewModel: HomeTableViewCellViewModel) {
		dayLabel.text = viewModel.name
		maxLabel.text = viewModel.max
		minLabel.text = viewModel.min

		iconImageView.load(with: viewModel.imageUrl) { [weak self] in
			switch $0 {
			case .success(let image):
				self?.iconImageView.image = image
			case .failure:
				self?.iconImageView.image = nil
			}
		}
	}

	// MARK: - Private

	private func setupUI() {
		contentView.backgroundColor = .clear
		backgroundColor = .clear

		dayLabel.textColor = ColorName.white.color
		dayLabel.font = Constant.Font.dayLabel

		maxLabel.textColor = ColorName.white.color
		maxLabel.font = Constant.Font.maxLabel

		minLabel.textColor = ColorName.white.color
		minLabel.font = Constant.Font.minLabel

		iconImageView.tintColor = ColorName.white.color

		selectionStyle = .none
	}
}
