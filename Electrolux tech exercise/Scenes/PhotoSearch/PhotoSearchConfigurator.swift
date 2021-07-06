//
//  PhotoSearchConfigurator.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import UIKit

final class PhotoSearchConfigurator {
  static func configure() -> UIViewController {
    let view = PhotoSearchViewController()
    let router = PhotoSearchRouter(view: view)
    let presenter = PhotoSearchPresenter()
    let interactor = PhotoSearchInteractor(presenter: presenter)
    presenter.view = view
    view.interactor = interactor
    view.router = router
    return view
  }
}
