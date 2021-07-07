//
//  PhotoSearchViewController.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 06.07.2021.
//
import SnapKit
import UIKit

protocol PhotoSearchDisplayable: AnyObject {
  func displayPhotos(_ photos: [PhotoViewModel])
  func displayError(_ message: String)
}

final class PhotoSearchViewController: UIViewController {
  //Const
  private let padding: CGFloat = 16
  private let columns = 3
  private let navTitle = "Flickr Photos"
  
  //Properties
  var interactor: PhotoSearchBusinessLogic!
  var router: PhotoSearchRouting!
  private var photos = [PhotoViewModel]()
  private var collectionView: UICollectionView!
  
  //Internal methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    interactor.searchPhotos()
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
    navigationItem.title = navTitle
    configureCollectionView()
    configureSearch()
  }
  
  //MARK: UISearchResultsUpdating
  override func updateSearchResults(for searchController: UISearchController) {
    interactor.searchPhotos(query: searchController.searchBar.text)
  }
}

private extension PhotoSearchViewController {
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    
    collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: layout
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsSelection = true
    collectionView.register(
      PhotoCollectionViewCell.self,
      forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
    )
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { maker in
      maker.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

//MARK: - PhotoSearchDisplayable
extension PhotoSearchViewController: PhotoSearchDisplayable {
  func displayPhotos(_ photos: [PhotoViewModel]) {
    self.photos = photos
    collectionView.reloadData()
  }
  
  func displayError(_ message: String) {
    router?.routeToError(message)
  }
}

//MARK: - UICollectionViewDataSource
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
}

//MARK: - UICollectionViewDelegate
extension PhotoSearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let photo = photos[indexPath.row]
    router.routeToDetail(photo)
  }
}

//MARK: - UICollectionViewFlowLayout
extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size: CGFloat = (collectionView.bounds.width - padding * CGFloat(columns + 1)) / CGFloat(columns)
    return CGSize(width: size, height: size)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(
      top: padding,
      left: padding,
      bottom: padding,
      right: padding
    )
  }
}

//MARK: - UISearchBarDelegate
extension PhotoSearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //add throttle here
    interactor.searchPhotos(query: searchText)
  }
}
