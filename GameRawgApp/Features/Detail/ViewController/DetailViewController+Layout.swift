//
//  DetailViewController+Layout.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import UIKit

extension DetailViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, _ in
      let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifiers[sectionNumber]
      
      switch sectionIdentifier {
      case .image:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
      case .description:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
      default:
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(70), heightDimension: .absolute(70)), subitems: []))
      }
    })
  }
}
