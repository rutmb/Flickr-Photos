//
//  PhotoDetailConfigurator.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import UIKit

final class PhotoDetailConfigurator {
  static func configure() -> PhotoDetailViewController {
    let view = PhotoDetailViewController()
    let router = PhotoDetailRouter(view: view)
    let presenter = PhotoDetailPresenter()
    let interactor = PhotoDetailInteractor(presenter: presenter)
    presenter.view = view
    view.interactor = interactor
    view.router = router
    return view
  }
}
