//
//  NetworkModeks.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

struct PhotoPlainObject: Codable {
  let title: String
  private let id: String
  private let server: String
  private let secret: String
}

extension PhotoPlainObject {
  private func configureImageUrl(size: String) -> String {
    "\(Config.flickrImageUrl)/\(server)/\(id)_\(secret)_\(size).jpg"
  }
  
  var previewURL: String {
    configureImageUrl(size: "m")
  }
  
  var largeURL: String {
    configureImageUrl(size: "b")
  }
}
