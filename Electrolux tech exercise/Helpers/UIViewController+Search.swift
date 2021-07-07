//
//  UIViewController+Search.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 07.07.2021.
//

import UIKit

extension UIViewController {
  func configureSearch(
    placeholder: String? = localized("search.placeholder")
  ) {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = placeholder
    definesPresentationContext = true
    searchController.searchResultsUpdater = self
    navigationItem.searchController = searchController
  }
}

extension UIViewController: UISearchResultsUpdating  {
  public func updateSearchResults(for searchController: UISearchController) {}
}
