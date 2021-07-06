//
//  PhotoSearchBarReusableView.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//

import UIKit

final class PhotoSearchBarReusableView: UICollectionReusableView {
  //Properties
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.placeholder = localized("search.placeholder")
    searchBar.searchBarStyle = .minimal
    return searchBar
  }()
  
  weak var delegate: UISearchBarDelegate? {
    didSet {
      searchBar.delegate = delegate
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    addSubview(searchBar)
    searchBar.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
