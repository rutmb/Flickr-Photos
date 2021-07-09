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
    //Create a detail view model from the response and pass to the view
    let viewModel = PhotoDetail.Fetch.ViewModel(
      title: response.photo.title,
      url: response.photo.imageURL,
      preview: response.preview
    )
    view.displayPhoto(viewModel)
  }
  
  func presentSave(_ response: PhotoDetail.Save.Response) {
    //Pass an error message (if saving failed) or a success messagre to the view
    let message = response.error?.localizedDescription ?? localized("photo_detail.save.success")
    let viewModel = PhotoDetail.Save.ViewModel(message: message)
    view.displaySave(viewModel)
  }
}
