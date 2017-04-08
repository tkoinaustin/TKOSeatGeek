//
//  SearchViewController.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/6/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  let viewModel = SearchViewModel()
  
  override func viewDidLoad() {
    viewModel.searchString = "Texas"
  }
  
}
