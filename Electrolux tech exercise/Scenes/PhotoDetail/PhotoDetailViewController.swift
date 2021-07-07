//
//  PhotoDetailViewController.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//
import SDWebImage
import UIKit

protocol PhotoDetailDisplayable: AnyObject {
  func displayPhoto(_ photo: PhotoDetail.Fetch.ViewModel)
  func displaySave(_ viewModel: PhotoDetail.Save.ViewModel)
}

final class PhotoDetailViewController: UIViewController {
  //Properties
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  var interactor: (PhotoDetailBusinessLogic & PhotoDetailDataSource)!
  var router: PhotoDetailRouting!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    interactor.fetchPhoto()
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
    let saveButton = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(didTapSaveButton)
    )
    navigationItem.rightBarButtonItem = saveButton
    view.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
    }
  }
  
  @objc func didTapSaveButton() {
    interactor.savePhoto()
  }
}

//MARK: - PhotoDetailDisplayable
extension PhotoDetailViewController: PhotoDetailDisplayable {
  func displayPhoto(_ photo: PhotoDetail.Fetch.ViewModel) {
    navigationItem.title = photo.title
    imageView.sd_setImage(
      with: photo.url,
      placeholderImage: photo.preview
    )
  }
  
  func displaySave(_ viewModel: PhotoDetail.Save.ViewModel) {
    router.routeToAlert(viewModel.message)
  }
}
