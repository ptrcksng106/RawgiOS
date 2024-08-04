//
//  HomeViewController.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 02/08/24.
//

import Combine
import UIKit
import Reusable
import SnapKit

class HomeViewController: UICollectionViewController, Reusable {
  var sections = HomeSection.allCases
  private let combineViewModel: CombineViewModel
  
  var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>? = nil
  private var subscriptions: Set<AnyCancellable> = []
  
  init(combineViewModel: CombineViewModel) {
    self.combineViewModel = combineViewModel
    super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    combineViewModel.fetchGameList(page: 1, pageSize: 10)
    combineViewModel.fetchDeveloperList(page: 1, pageSize: 10)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureDataSource()
    observeValues()
    navigationItem.title = "Home"
  }
  
  private func configureViews() {
    collectionView.register(cellType: BannerCell.self)
    collectionView.register(cellType: DeveloperCell.self)
    collectionView.collectionViewLayout = createLayout()
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: collectionView) { _, indexPath, itemIdentifier in
      self.cellForItem(itemIdentifier, for: indexPath)
    }
    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      self.supplementaryView(in: collectionView, kind: kind, at: indexPath)
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    snapshot.appendSections(sections)
    dataSource?.apply(snapshot, animatingDifferences: false)
  }
  
  func observeValues() {
    var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    
    combineViewModel.$games
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("Failed to receive games: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] games in
        guard let self = self else { return }
        // Check if 'usp' section already exists, and add if necessary
        if !snapshot.sectionIdentifiers.contains(.usp) {
          snapshot.appendSections([.usp])
        }
        let gameItems = games.map { HomeItem.usp(item: $0) }
        snapshot.appendItems(gameItems, toSection: .usp)
        
        // Apply the updated snapshot
        self.dataSource?.apply(snapshot, animatingDifferences: true)
      })
      .store(in: &subscriptions)
    
    combineViewModel.$developers
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("Failed to receive games: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] developers in
        guard let self = self else { return }
        if !snapshot.sectionIdentifiers.contains(.developer) {
          snapshot.appendSections([.developer])
        }
        
        let developerItems = developers.map { HomeItem.developer(item: $0) }
        snapshot.appendItems(developerItems, toSection: .developer)
        
        // Apply the updated snapshot
        self.dataSource?.apply(snapshot, animatingDifferences: true)
      })
      .store(in: &subscriptions)
    
  }
}

extension HomeViewController {
  private func cellForItem(_ itemIdentifier: HomeItem, for indexPath: IndexPath) -> UICollectionViewCell? {
    switch itemIdentifier {
    case .usp(let item):
      let cell: BannerCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configureViews(with: item)
      cell.bannerClicked = { [weak self] (game: Result) in
        guard let self = self else { return }
        let detailVC = DetailViewController(detailId: game.id, viewModel: DetailViewModel())
        navigationController?.pushViewController(detailVC, animated: true)
      }
      return cell
    case .developer(let item):
      let cell: DeveloperCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configureViews(with: item)
      return cell
    }
  }
  
  private func supplementaryView(in collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
    let sectionIdentifier = dataSource?.snapshot().sectionIdentifiers[indexPath.section]
    
    guard kind == UICollectionView.elementKindSectionHeader else { return nil }
    switch sectionIdentifier {
    default:
      return nil
    }
  }
}
