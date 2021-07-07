//
//  PhotoDetailRouter.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 07.07.2021.
//

import UIKit

protocol PhotoDetailRouting: AnyObject {
  func routeToAlert(_ message: String)
}

final class PhotoDetailRouter: PhotoDetailRouting {
  weak var view: UIViewController?
  
  init(view: UIViewController) {
    self.view = view
  }
  
  func routeToAlert(_ message: String) {
    view?.presentAlert(message: message)
  }
}
