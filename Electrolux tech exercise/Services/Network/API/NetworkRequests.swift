//
//  NetworkRequests.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import Foundation

struct NetworkRequests {
  struct Search {
    let query: String
    let apiKey: String
    let page: Int
    let count: Int
    let method = "flickr.photos.search"
    let format = "json"
    let nojsoncallback = "true"
    let extras = ["media", "url_m"]
  }
}
