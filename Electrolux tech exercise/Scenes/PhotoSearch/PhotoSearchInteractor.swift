//
//  PhotoSearchInteractor.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import Foundation

protocol PhotoSearchBusinessLogic {
  func searchElectrolux()
  func searchPhotos(query: String?)
}

final class PhotoSearchInteractor: PhotoSearchBusinessLogic {
  private var networkService: NetworkFetchable
  private var parser: JSONParseable
  private var presenter: PhotoSearchPresentable
  private let electroluxSearch = "Electrolux"
  
  init(
    networkService: NetworkFetchable = NetworkService(),
    parser: JSONParseable = JSONParser(),
    presenter: PhotoSearchPresentable = PhotoSearchPresenter()
    ) {
    self.networkService = networkService
    self.parser = parser
    self.presenter = presenter
  }
  
  func searchElectrolux() {
    searchPhotos(query: electroluxSearch)
  }
  
  func searchPhotos(query: String?) {
    let request = NetworkRequests.Search(
      query: query?.nilIfEmpfy ?? electroluxSearch,
      apiKey: Config.apiKey,
      page: 1,
      count: Config.perPage
    )
    networkService.searchPhotos(request: request) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        let photos: [PhotoPlainObject] = self.parser.parseArray(data: data, path: "photos.photo") ?? [PhotoPlainObject]()
        self.presenter.presentPhotos(.success(photos))
        
      case .failure(let error):
        self.presenter.presentPhotos(.failure(error))
      }
    }
  }
}
