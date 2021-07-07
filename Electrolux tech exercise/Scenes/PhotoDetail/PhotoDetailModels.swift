//
//  PhotoDetailModels.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 07.07.2021.
//

import UIKit

struct PhotoDetail {
  struct Fetch {
    struct Response {
      let photo: PhotoViewModel
      let preview: UIImage?
    }
    struct ViewModel {
      let title: String
      let url: URL?
      let preview: UIImage?
    }
  }
  struct Save {
    struct Response {
      let error: Error?
    }
    struct ViewModel {
      let message: String
    }
  }
}
