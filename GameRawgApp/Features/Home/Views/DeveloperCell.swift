//
//  DeveloperCell.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Kingfisher
import Reusable
import UIKit

class DeveloperCell: UICollectionViewCell, Reusable {
  lazy var imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    return img
  }()
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    view.layer.cornerRadius = 3
    view.clipsToBounds = true
    return view
  }()
  
  lazy var lblText: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    label.textColor = .white
    label.numberOfLines = 2
    label.textAlignment = .center
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
    contentView.addSubview(imageView)
    imageView.addSubview(containerView)
    containerView.addSubview(lblText)
    
    imageView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    containerView.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(20)
    }
    
    lblText.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(3.5)
      make.bottom.equalToSuperview().inset(3.5)
      make.leading.equalToSuperview().offset(8)
      make.trailing.equalToSuperview().inset(8)
    }
  }
  
  func configureViews(with item: Developer) {
    imageView.kf.setImage(with: URL(string: item.imageBackground ?? ""))
    lblText.text = item.name
  }
}
