//
//  SearchResultCell.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit
import PromiseKit

class SearchResultCell: UITableViewCell {
  var event: Event! { didSet {
    self.mainImage.image = UIImage(named: "no_pic")
    self.id = event.id
    self.titleLabel.text = event.title
    self.locationLabel.text = event.location
    self.dateLabel.text = event.startDate
    _ = loadImage(from: event.imageUrl).then { image -> Void in
      self.mainImage.image = image
    }
  }}
  
  var id: Int! { didSet {
    likeImage.isHidden = !Favorites.isFavorite(id)
  }}
  //swiftlint:disable private_outlet
  @IBOutlet private(set) weak var mainImage: UIImageView! { didSet {
    //swiftlint:enable private_outlet
    mainImage.layer.cornerRadius = 6.5
    mainImage.clipsToBounds = true
  }}
  @IBOutlet private weak var likeImage: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var locationLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
  func loadImage(from url: URL?) -> Promise<UIImage> {
    return Promise<UIImage> { fulfill, reject in
      guard url != nil else { reject(NSError.cancelledError()); return }
      
      URLSession.shared.dataTask(with: url!) { data, _, _ in
        switch data {
        case .none: reject(NSError.cancelledError())
        case .some(let imageData):
          if let image = UIImage(data: imageData) {
            fulfill(image)
          }
        }
        }.resume()
    }
  }

}
