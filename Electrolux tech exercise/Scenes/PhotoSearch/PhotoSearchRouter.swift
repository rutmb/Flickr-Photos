//
//  PhotoSearchRouter.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import UIKit

protocol PhotoSearchRouting: AnyObject {
  func routeToDetail(_ viewModel: PhotoViewModel)
  func routeToError(_ message: String)
}

final class PhotoSearchRouter: PhotoSearchRouting {
  weak var view: UIViewController?
  
  init(view: UIViewController) {
    self.view = view
  }
  
  func routeToDetail(_ viewModel: PhotoViewModel) {
    let photoDetailVC = PhotoDetailConfigurator.configure()
    photoDetailVC.interactor.photo = viewModel
    view?.navigationController?.pushViewController(
      photoDetailVC,
      animated: true
    )
  }
  
  func routeToError(_ message: String) {
    view?.presentErrorAlert(message)
  }
}
