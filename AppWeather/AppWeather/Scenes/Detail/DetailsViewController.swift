//
//  DetailsViewController.swift
//  AppWeather
//
//  Created by Johnson-Riche Louis on 28/01/2020.
//  Copyright (c) 2020 Johnson-Richie Louis. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsView: class {
	func update(viewModel: DetailsViewModel)
	func updateError(viewModel: DetailsErrorViewModel)
}

class DetailsViewController: UIViewController {

	// MARK: - Enum

	private enum Constant {
		static let animationDuration = 0.25

		enum Font {
			enum Label {
				static let name = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 30: 24)
				static let description = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 24: 18)
				static let temperature = UIFont(name: "HelveticaNeue", size: UIDevice.isIpad ? 80: 80)
			}
		}

		enum CollectionView {
			static let numberOfColumns = 2
			static let itemHeight: CGFloat = UIDevice.isIpad ? 80 : 50
			static let lineSpacing: CGFloat = UIDevice.isIpad ? 20 : 16
			static let interitemSpacing: CGFloat = 4
			static let insetValue: CGFloat = UIDevice.isIpad ? 8 : 4
			static let inset = UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue)
		}
	}

	// MARK: - Property

	var viewModel: DetailsViewModel?

	// MARK: - IBOutlet

	@IBOutlet weak var indicatorView: UIActivityIndicatorView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!

	// MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fetchContents()
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		collectionView.collectionViewLayout.invalidateLayout()
	}

	// MARK: - Private

	private func setupUI() {
		view.backgroundColor = UIColor.appBlue
		nameLabel.textColor = UIColor.appWhite
		nameLabel.font = Constant.Font.Label.name
		nameLabel.alpha = 0

		descriptionLabel.textColor = UIColor.appWhite
		descriptionLabel.font = Constant.Font.Label.description
		descriptionLabel.alpha = 0

		temperatureLabel.textColor = UIColor.appWhite
		temperatureLabel.font = Constant.Font.Label.temperature
		temperatureLabel.alpha = 0

		collectionView.backgroundColor = .clear
		collectionView.alpha = 0
		collectionView.register(UINib(nibName: DetailsCollectionViewCell.identifier, bundle: nil),
								forCellWithReuseIdentifier: DetailsCollectionViewCell.identifier)

		let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack]
		navigationController?.navigationBar.titleTextAttributes = textAttributes
		title = "detail.title".localized()
	}

	private func fetchContents() {
		indicatorView.isHidden = false
		viewModel?.fetchDatas()
	}
}

// MARK: - DetailsDisplayLogic

extension DetailsViewController: DetailsView {

	func update(viewModel: DetailsViewModel) {
		self.viewModel = viewModel
		indicatorView.isHidden = true
		nameLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
		temperatureLabel.text = viewModel.temperature
		UIView.animate(withDuration: Constant.animationDuration) {
			self.nameLabel.alpha = 1
			self.descriptionLabel.alpha = 1
			self.temperatureLabel.alpha = 1
			self.collectionView.alpha = 1
		}
		collectionView.reloadData()
	}

	func updateError(viewModel: DetailsErrorViewModel) {
		indicatorView.isHidden = true
		let alert = UIAlertController(title: viewModel.title,
									  message: viewModel.message,
									  preferredStyle: .alert)
		let action = UIAlertAction(title: viewModel.actionTitle, style: .default) { _ in
			self.dismiss(animated: true, completion: nil)
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource

extension DetailsViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.additionnal.count ?? 0
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.identifier,
															for: indexPath) as? DetailsCollectionViewCell,
			let viewModel = viewModel?.additionnal[indexPath.row] else {
				return UICollectionViewCell()
		}
		let cellViewModel = DetailsCollectionViewCellViewModel(placeholder: viewModel.placeholder,
															   text: viewModel.text)
		cell.configure(viewModel: cellViewModel)
		return cell
	}

}

// MARK: - UICollectionViewDataSource

extension DetailsViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let collectionWidth = collectionView.bounds.width
		let nbItemsByLine = CGFloat(Constant.CollectionView.numberOfColumns)
		let margins = (Constant.CollectionView.inset.left + Constant.CollectionView.inset.right) * nbItemsByLine
		let itemsSpacing = Constant.CollectionView.interitemSpacing * nbItemsByLine - 1
		let width = (collectionWidth - margins - itemsSpacing) / nbItemsByLine
		return CGSize(width: width, height: Constant.CollectionView.itemHeight)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constant.CollectionView.lineSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Constant.CollectionView.interitemSpacing
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Constant.CollectionView.inset
	}
}
