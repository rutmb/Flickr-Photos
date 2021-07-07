//
//  PhotoDetailInteractor.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//
import SDWebImage
import Foundation

protocol PhotoDetailBusinessLogic {
  func fetchPhoto()
  func savePhoto()
}

protocol PhotoDetailDataSource {
  var photo: PhotoViewModel! { get set }
}

final class PhotoDetailInteractor: PhotoDetailBusinessLogic, PhotoDetailDataSource {
  
  var photo: PhotoViewModel!

  let presenter: PhotoDetailPresentable
  let imageSaver: ImageStoreable
  
  init(
    presenter: PhotoDetailPresentable = PhotoDetailPresenter(),
    imageSaver: ImageStoreable = ImageSaveService()
    ) {
    self.presenter = presenter
    self.imageSaver = imageSaver
  }
  
  func fetchPhoto() {
    let response = PhotoDetail.Fetch.Response(
      photo: photo,
      preview: previewImage()
    )
    presenter.presentPhoto(response)
  }
  
  func savePhoto() {
    guard let image = fullImage() ?? previewImage() else {
      return
    }
    imageSaver.saveImage(image) { [weak self] error in
      let response = PhotoDetail.Save.Response(error: error)
      self?.presenter.presentSave(response)
    }
  }
}

private extension PhotoDetailInteractor {
  func previewImage() -> UIImage? {
    return SDImageCache.shared.imageFromMemoryCache(
      forKey: photo.previewURL?.absoluteString
    )
  }
  
  func fullImage() -> UIImage? {
    return SDImageCache.shared.imageFromMemoryCache(
      forKey: photo.imageURL?.absoluteString
    )
  }
}
