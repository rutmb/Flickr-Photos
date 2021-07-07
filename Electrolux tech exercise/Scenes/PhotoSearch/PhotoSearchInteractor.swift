//
//  PhotoSearchInteractor.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import Foundation

protocol PhotoSearchBusinessLogic {
  func searchPhotos(query: String?)
}

extension PhotoSearchBusinessLogic {
  func searchPhotos() {
    searchPhotos(query: "")
  }
}

final class PhotoSearchInteractor: PhotoSearchBusinessLogic {
  //Const
  private let electroluxSearch = "Electrolux"

  //Properties
  private var networkService: NetworkFetchable
  private var parser: JSONParseable
  private var presenter: PhotoSearchPresentable
  private var searchTask: DispatchWorkItem?
  private var searchQuery: String?

  init(
    networkService: NetworkFetchable = NetworkService(),
    parser: JSONParseable = JSONParser(),
    presenter: PhotoSearchPresentable = PhotoSearchPresenter()
  ) {
    self.networkService = networkService
    self.parser = parser
    self.presenter = presenter
  }
  
  func searchPhotos(query: String? = "") {
    searchTask?.cancel()
    let task = DispatchWorkItem { [weak self] in
      self?.internalSearch(query: query)
    }
    searchTask = task
    onMainThread(after: 0.5, task: task)
  }
}

private extension PhotoSearchInteractor {
  func internalSearch(query: String?) {
    guard searchQuery != query else {
      return
    }
    searchQuery = query
    
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
        let photos: [PhotoPlainObject] = self.parser.parseArray(
          data: data,
          path: "photos.photo"
        ) ?? [PhotoPlainObject]()
        self.presenter.presentPhotos(.success(photos))
        
      case .failure(let error):
        self.presenter.presentPhotos(.failure(error))
      }
    }
  }
}
