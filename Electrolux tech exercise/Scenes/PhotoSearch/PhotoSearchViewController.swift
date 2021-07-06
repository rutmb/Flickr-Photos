//
//  PhotoSearchViewController.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//
import SnapKit
import UIKit

protocol PhotoSearchDisplayable: UIViewController {
  func displayPhotos(_ photos: [PhotoViewModel])
  func displayError(_ message: String)
}

final class PhotoSearchViewController: UIViewController {
  //Properties
  var interactor: PhotoSearchBusinessLogic!
  var router: PhotoSearchRouting!
  private var photos = [PhotoViewModel]()
  
  private var collectionView: UICollectionView!
  
  //Internal methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    interactor.searchElectrolux()
  }
  
  private func configureUI() {
    configureCollectionView()
  }
}

private extension PhotoSearchViewController {
  func configureCollectionView() {
    let padding: CGFloat = 16
    let columns = 3
    let size: CGFloat = (view.bounds.width - padding * CGFloat(columns + 1)) / CGFloat(columns)
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: padding,
      left: padding,
      bottom: padding,
      right: padding
    )
    layout.headerReferenceSize = CGSize(width: 0, height: 40)
    layout.itemSize = CGSize(width: size, height: size)
    
    collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: layout
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemGray4
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsSelection = true
    collectionView.register(
      PhotoCollectionViewCell.self,
      forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
    )
    collectionView.register(
      PhotoSearchBarReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: PhotoSearchBarReusableView.identifier
    )
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { maker in
      maker.edges.equalTo(view)
    }
  }
}

extension PhotoSearchViewController: PhotoSearchDisplayable {
  func displayPhotos(_ photos: [PhotoViewModel]) {
    self.photos = photos
    collectionView.reloadData()
  }
  
  func displayError(_ message: String) {
    router?.routeToError(message)
  }
}

extension PhotoSearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PhotoCollectionViewCell.identifier,
      for: indexPath
    ) as! PhotoCollectionViewCell
    cell.configure(with: photos[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let searchBarView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: PhotoSearchBarReusableView.identifier,
      for: indexPath
    ) as! PhotoSearchBarReusableView
    searchBarView.delegate = self
    return searchBarView
  }
}

extension PhotoSearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}

extension PhotoSearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //add throttle here
    interactor.searchPhotos(query: searchText)
  }
}
