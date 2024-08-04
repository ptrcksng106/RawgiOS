//
//  HomeViewController+Layout.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 02/08/24.
//

import UIKit

extension HomeViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, _ in
      let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifiers[sectionNumber]
      
      switch sectionIdentifier {
      case .usp:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(259)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
      case .developer:
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(102), heightDimension: .absolute(157)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(102), heightDimension: .absolute(157)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(20)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 0)
        return section
      default:
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(70), heightDimension: .absolute(70)), subitems: []))
      }
    })
  }
}
