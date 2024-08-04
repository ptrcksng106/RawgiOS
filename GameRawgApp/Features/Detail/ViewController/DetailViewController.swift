//
//  DetailViewController.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Combine
import UIKit
import Reusable
import SnapKit

class DetailViewController: UICollectionViewController, Reusable {
  var sections = DetailSection.allCases
  var dataSource: UICollectionViewDiffableDataSource<DetailSection, DetailItem>? = nil
  var detailId: Int?
  private var subscriptions: Set<AnyCancellable> = []
  private let viewModel: DetailViewModel
  
  init(detailId: Int, viewModel: DetailViewModel) {
    self.detailId = detailId
    self.viewModel = viewModel
    super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getDetailGame(id: detailId ?? 0)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Detail"
    configureViews()
    configureDataSource()
    observeValue()
  }
  
  private func configureViews() {
    collectionView.register(cellType: ImageCell.self)
    collectionView.register(cellType: DescriptionCell.self)
    collectionView.collectionViewLayout = createLayout()
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<DetailSection, DetailItem>(collectionView: collectionView) { _, indexPath, itemIdentifier in
      self.cellForItem(itemIdentifier, for: indexPath)
    }
    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      self.supplementaryView(in: collectionView, kind: kind, at: indexPath)
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
    snapshot.appendSections(sections)
    dataSource?.apply(snapshot, animatingDifferences: false)
  }
  
  func observeValue() {
    var snapshot = NSDiffableDataSourceSnapshot<DetailSection, DetailItem>()
    
    viewModel.$detailGame
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("Failed to receive games: \(error.localizedDescription)")
        }
      }, receiveValue: { [weak self] detail in
        guard let self = self else { return }
        if !snapshot.sectionIdentifiers.contains(.image) {
          snapshot.appendSections([.image, .description])
        }
        let detail = detail.map { [DetailItem.image(item: $0), DetailItem.description(item: $0)] }
        snapshot.appendItems(detail ?? [], toSection: .image)
        snapshot.appendItems(detail ?? [], toSection: .description)
        
        // Apply the updated snapshot
        self.dataSource?.apply(snapshot, animatingDifferences: true)
      })
      .store(in: &subscriptions)
  }
}

extension DetailViewController {
  private func cellForItem(_ itemIdentifier: DetailItem, for indexPath: IndexPath) -> UICollectionViewCell? {
    switch itemIdentifier {
    case .image(let item):
      let cell: ImageCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configureViews(with: item)
      return cell
    case .description(let item):
      let cell: DescriptionCell = collectionView.dequeueReusableCell(for: indexPath)
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
