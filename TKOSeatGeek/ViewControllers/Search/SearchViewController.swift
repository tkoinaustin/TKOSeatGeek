//
//  SearchViewController.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/6/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  weak var viewModel = SearchViewModel()
  let provider = SearchDataProvider()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    viewModel?.searchString = "Texas"
    provider.viewModel = viewModel
    
    self.tableView.dataSource = provider
    provider.registerCells(for: self.tableView)
  }
  
}
