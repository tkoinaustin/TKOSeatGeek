//
//  IntroViewController.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/6/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  
  @IBOutlet private weak var continueButton: UIButton!
  @IBOutlet private weak var instructionsLabel: UILabel!
  @IBOutlet private weak var topLabel: UILabel!
  @IBOutlet private weak var middleLabel: UILabel!
  @IBOutlet private weak var bottomLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let height = view.frame.height
    let transformButton = CGAffineTransform.identity.translatedBy(x: 0, y: height)
    continueButton.transform = transformButton
    continueButton.tintColor = UIColor.white
    instructionsLabel.transform = transformButton
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let height = view.frame.height
    let transformLogo = CGAffineTransform.identity.translatedBy(x: 0, y: -height)
    UIView.animate(withDuration: 0.8, delay: 0.1, options: UIViewAnimationOptions(), animations: {
      self.topLabel.transform = transformLogo
      self.middleLabel.transform = transformLogo
      self.bottomLabel.transform = transformLogo
      self.continueButton.transform = CGAffineTransform.identity
      self.instructionsLabel.transform = CGAffineTransform.identity
    }, completion: nil)
    
  }
}
