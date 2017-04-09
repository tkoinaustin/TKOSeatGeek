//
//  DetailViewController.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var event: Event!  
  var image: UIImage?
  
  @IBOutlet weak var mainImage: UIImageView! { didSet {
    mainImage.layer.cornerRadius = 6.5
    mainImage.clipsToBounds = true
    mainImage.image = image
  }}
  
  @IBOutlet weak var startDate: UILabel! { didSet {
      startDate.text = event?.startDate
  }}
  
  @IBOutlet weak var location: UILabel! { didSet {
      location.text = event?.location
  }}
  
  @IBOutlet weak var eventName: UILabel! { didSet {
    eventName.text = event?.title
  }}

  @IBOutlet weak var toggleLike: UIButton!
  
  @IBAction func toggleLikeAction(_ sender: UIButton) {
  }
  
  
  @IBAction func dismissAction(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  func setup(_ event: Event, image: UIImage?) {
    self.event = event
    self.image = image
  }
}
