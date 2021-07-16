//
//  PhotoSearchPresenter.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

protocol PhotoSearchPresentable {
  typealias PhotoSearchResponse = Result<[PhotoPlainObject], NetworkError>

  func presentPhotos(_ response: PhotoSearchResponse)
}

final class PhotoSearchPresenter: PhotoSearchPresentable {
  weak var view: PhotoSearchDisplayable?
  
  func presentPhotos(_ response: PhotoSearchResponse) {
    //Convert plain objects to view model and pass them to the view on the main thread
    switch response {
    case .success(let photos):
      let viewModels = photos.compactMap {
        PhotoViewModel(
          title: $0.title,
          previewURL: URL(string: $0.previewURL),
          imageURL: URL(string: $0.largeURL)
        )
      }
      onMainThread {
        self.view?.displayPhotos(viewModels)
      }
      
    case .failure(let error):
      //Pass the error to the view on the main thread
      onMainThread {
        self.view?.displayError(error.localizedDescription)
      }
    }
  }
}
