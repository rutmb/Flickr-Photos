//
//  ListInteractor.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import Foundation

protocol PhotoSearchBusinessLogic {
  func searchPhotos(query: String?)
}

final class PhotoSearchInteractor: PhotoSearchBusinessLogic {
  private var networkService: NetworkFetchable
  private var parser: JSONParseable
  
  init(
    networkService: NetworkFetchable = NetworkService(),
    parser: JSONParseable = JSONParser()
    ) {
    self.networkService = networkService
    self.parser = parser
  }
  
  func searchPhotos(query: String?) {
    let request = NetworkRequests.Search(
      query: query ?? "",
      apiKey: Config.apiKey,
      page: 1,
      count: Config.perPage
    )
    networkService.searchPhotos(request: request) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        let items: [PhotoPlainObject]? = self.parser.parseArray(data: data, path: "photos.photo")
        print(items)
        
      case .failure(let error):
        print(error)        
      }
    }
  }
}
