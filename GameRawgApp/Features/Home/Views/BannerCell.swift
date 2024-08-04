//
//  BannerCell.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 02/08/24.
//

import Kingfisher
import Reusable
import UIKit

class BannerCell: UICollectionViewCell, Reusable {
  
  lazy var imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.isUserInteractionEnabled = true
    return img
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.style = .medium
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()
  
  var bannerClicked: ((Result) -> Void)?
  private var currentItem: Result?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraint()
    addTapGesture()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func setConstraint() {
    contentView.addSubview(imageView)
    imageView.addSubview(activityIndicator)
    
    imageView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  func configureViews(with item: Result) {
    currentItem = item
    activityIndicator.startAnimating()
    imageView.kf.setImage(with: URL(string: item.backgroundImage ?? "")) { [weak self] result in
      switch result {
      case .success:
        self?.activityIndicator.stopAnimating()
      case .failure:
        self?.activityIndicator.stopAnimating()
      }
    }
  }
  
  private func addTapGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    imageView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc private func handleTap() {
    guard let item = currentItem else { return }
    bannerClicked?(item)
  }
}
