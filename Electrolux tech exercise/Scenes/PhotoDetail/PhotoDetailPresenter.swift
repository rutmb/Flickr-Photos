//
//  PhotoDetailPresenter.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

protocol PhotoDetailPresentable {
  func presentPhoto(_ response: PhotoDetail.Fetch.Response)
  func presentSave(_ response: PhotoDetail.Save.Response)
}

final class PhotoDetailPresenter: PhotoDetailPresentable {
  weak var view: PhotoDetailDisplayable!
  
  func presentPhoto(_ response: PhotoDetail.Fetch.Response) {
    let viewModel = PhotoDetail.Fetch.ViewModel(
      title: response.photo.title,
      url: response.photo.imageURL,
      preview: response.preview
    )
    view.displayPhoto(viewModel)
  }
  
  func presentSave(_ response: PhotoDetail.Save.Response) {
    let message = response.error?.localizedDescription ?? localized("photo_detail.save.success")
    let viewModel = PhotoDetail.Save.ViewModel(message: message)
    view.displaySave(viewModel)
  }
}
