//
//  File.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 05.07.2021.
//

import SwiftyJSON

protocol JSONParseable {
  func parse<T: Decodable>(data: Data, path: String?) -> T?
  func parseArray<T: Decodable>(data: Data, path: String?) -> [T]?
}

final class JSONParser: JSONParseable {
  private var decoder: JSONDecoder
  
  init(decoder: JSONDecoder = JSONDecoder()) {
    self.decoder = decoder
  }
  
  func parse<T: Decodable>(data: Data, path: String? = nil) -> T? {
    guard let path = path else {
      return try? decoder.decode(T.self, from: data)
    }
    guard
      let json = try? JSON(data: data),
      let rawData = try? json[path].rawData()
      else {
      return nil
    }
    return try? decoder.decode(T.self, from: rawData)
  }
  
  func parseArray<T: Decodable>(data: Data, path: String? = nil) -> [T]? {
    guard let path = path?.components(separatedBy: ".") else {
      return try? decoder.decode([T].self, from: data)
    }
    guard
      let json = try? JSON(data: data),
      let rawData = try? json[path].rawData()
      else {
      return nil
    }
    return try? decoder.decode([T].self, from: rawData)
  }
}
