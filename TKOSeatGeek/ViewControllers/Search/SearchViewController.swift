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
  let provider = SearchDataProvider()
  
  @IBOutlet weak var searchBar: UISearchBar! { didSet {
    searchBar.showsCancelButton = true
    searchBar.placeholder = "Looking for something?"
  }}
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    viewModel.updateUI = { self.tableView.reloadData() }
    provider.viewModel = viewModel
    
    searchBar.delegate = self
    
    tableView.dataSource = provider
    tableView.delegate = self
    provider.registerCells(for: self.tableView)
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.searchBar.endEditing(true)
  }
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchString = searchText
    if searchText == "" { self.searchBar.endEditing(true) }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
}
