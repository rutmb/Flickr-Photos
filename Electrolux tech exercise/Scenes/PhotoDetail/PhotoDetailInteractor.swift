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
    //Pass the view model and preview image to the presenter
    let response = PhotoDetail.Fetch.Response(
      photo: photo,
      preview: previewImage()
    )
    presenter.presentPhoto(response)
  }
  
  func savePhoto() {
    //Get the full size image or the preview image (if failed) and save to the photo album
    guard let image = fullImage() ?? previewImage() else {
      return
    }
    imageSaver.saveImage(image) { [weak self] error in
      //Pass the optional error to the presetner
      let response = PhotoDetail.Save.Response(error: error)
      self?.presenter.presentSave(response)
    }
  }
}

private extension PhotoDetailInteractor {
  func previewImage() -> UIImage? {
    //Fetch a preview image from the memory cache
    return SDImageCache.shared.imageFromMemoryCache(
      forKey: photo.previewURL?.absoluteString
    )
  }
  
  func fullImage() -> UIImage? {
    //Fetch a full image from the memory cache
    return SDImageCache.shared.imageFromMemoryCache(
      forKey: photo.imageURL?.absoluteString
    )
  }
}
