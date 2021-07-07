//
//  PhotoCollectionViewCell.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//
import SnapKit
import SDWebImage
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {  
  override var isSelected: Bool {
    didSet {
      contentView.backgroundColor = isSelected ? .systemGray : .clear
    }
  }
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 10)
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
    contentView.addSubview(label)
    label.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.height.equalTo(16)
    }
    contentView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalTo(label.snp.top)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
  }
  
  func configure(with photo: PhotoViewModel) {
    activityIndicator.startAnimating()
    label.text = photo.title
    imageView.sd_setImage(with: photo.previewURL) { [weak self] image, _, _, _ in
      self?.activityIndicator.stopAnimating()
    }
  }
}
