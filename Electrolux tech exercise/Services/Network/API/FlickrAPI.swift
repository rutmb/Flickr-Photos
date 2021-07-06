//
//  FlickrAPI.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import Moya

enum FlickrAPI {
  case search(_ request: NetworkRequests.Search)
}

extension FlickrAPI: TargetType {
  var baseURL: URL {
    URL(string: Config.flickrAPIUrl)!
  }
  
  var path: String {
    "/services/rest"
  }
  
  var method: Method {
    .get
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case .search(let request):
      let params: [String: Any] = [
        "tags": request.query,
        "api_key": request.apiKey,
        "page": request.page,
        "per_page": request.count,
        "method": request.method,
        "format": request.format,
        "nojsoncallback": request.nojsoncallback,
        "extras": request.extras
      ]
      return .requestParameters(
        parameters: params,
        encoding: URLEncoding(arrayEncoding: .noBrackets)
      )
    }
  }
  
  var headers: [String : String]? {
    nil
  }
}
