//
//  ImageSaveService.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 07.07.2021.
//

import UIKit

typealias ImageSaveCompletion = (Error?) -> ()

protocol ImageStoreable {
  func saveImage(_ image: UIImage, completion: @escaping ImageSaveCompletion)
}

final class ImageSaveService: NSObject, ImageStoreable {
  private var completion: ImageSaveCompletion?
  
  func saveImage(
    _ image: UIImage,
    completion: @escaping ImageSaveCompletion
  ) {
    self.completion = completion
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(didSaveImage), nil)
  }
  
  @objc func didSaveImage(
    _ image: UIImage,
    didFinishSavingWithError error: Error?,
    contextInfo: UnsafeRawPointer
  ) {
    completion?(error)
  }
}
