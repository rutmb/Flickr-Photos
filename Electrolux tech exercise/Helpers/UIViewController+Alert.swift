//
//  UIViewController+Alert.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

import UIKit

extension UIViewController {
  func presentErrorAlert(_ message: String?) {
    presentAlert(title: localized("error"), message: message)
  }
  
  func presentAlert(
    title: String? = nil,
    message: String?,
    completion: (() -> ())? = nil,
    handler: (() -> ())? = nil
  ) {
    let alertVC = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(
      title: localized("global.ok"),
      style: .default) { _ in
      handler?()
    }
    alertVC.addAction(okAction)
    present(
      alertVC,
      animated: true,
      completion: completion
    )
  }
}
