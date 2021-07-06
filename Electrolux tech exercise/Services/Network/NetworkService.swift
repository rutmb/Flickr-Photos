//
//  NetworkService.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//
import Moya

enum NetworkError: LocalizedError {
  case emptyContent
  case invalidUrl
  case error(Error)

  var errorDescription: String? {
    switch self {
    case .error(let error):
      return error.localizedDescription

    case .invalidUrl:
      return localized("error.invalid_url")

    case .emptyContent:
      return localized("error.empty_content")
    }
  }
}

typealias NetworkResult = Result<Data, NetworkError>
typealias NetworkResultBlock = (NetworkResult) -> ()

protocol NetworkFetchable {
  func searchPhotos(
    request: NetworkRequests.Search,
    completion: @escaping NetworkResultBlock
  )
}

final class NetworkService: NetworkFetchable {
  lazy var provider = MoyaProvider<FlickrAPI>()

  func searchPhotos(
    request: NetworkRequests.Search,
    completion: @escaping NetworkResultBlock
  )  {
    provider.request(.search(request)) { result in
      switch result {
      case .success(let response):
        completion(.success(response.data))
        
      case .failure(let error):
        completion(.failure(.error(error)))
      }
    }
  }
}
