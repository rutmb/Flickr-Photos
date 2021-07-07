//
//  PhotoSearchPresenter.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

typealias PhotoSearchResponse = Result<[PhotoPlainObject], NetworkError>

protocol PhotoSearchPresentable {
  func presentPhotos(_ response: PhotoSearchResponse)
}

final class PhotoSearchPresenter: PhotoSearchPresentable {
  weak var view: PhotoSearchDisplayable?
  
  func presentPhotos(_ response: PhotoSearchResponse) {
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
      onMainThread {
        self.view?.displayError(error.localizedDescription)
      }
    }
  }
}
