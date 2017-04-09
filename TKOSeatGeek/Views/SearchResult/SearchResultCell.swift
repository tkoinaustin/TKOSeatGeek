//
//  SearchResultCell.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
//  weak var content: Event!
  
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var mainImage: UIImageView! { didSet {
    mainImage.layer.cornerRadius = 6.5
    mainImage.clipsToBounds = true
  }}
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
}
