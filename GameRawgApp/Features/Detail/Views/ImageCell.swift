//
//  ImageCell.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Kingfisher
import Reusable
import UIKit

class ImageCell: UICollectionViewCell, Reusable {
  
  lazy var imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.isUserInteractionEnabled = true
    return img
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureViews(with item: Detail) {
    imageView.kf.setImage(with: URL(string: item.backgroundImage ?? ""))
  }
  
  private func setConstraint() {
    contentView.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
