//
//  DescriptionCell.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Reusable
import UIKit

class DescriptionCell: UICollectionViewCell, Reusable {
  
  lazy var lblTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.numberOfLines = 2
    return label
  }()
  
  lazy var lblDescription: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.numberOfLines = 7
    label.textAlignment = .justified
    return label
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraint() {
    contentView.addSubview(lblTitle)
    contentView.addSubview(lblDescription)
    
    lblTitle.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.top.equalToSuperview().offset(16)
    }
    
    lblDescription.snp.makeConstraints { make in
      make.top.equalTo(lblTitle.snp.bottom).offset(8)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
  
  func configureViews(with item: Detail) {
    lblTitle.text = item.name
    lblDescription.text = item.description
  }
}
