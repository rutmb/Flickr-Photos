//
//  String+Empty.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import Foundation

extension String {
  var nilIfEmpfy: String? {
    isEmpty ? nil : self
  }
}
