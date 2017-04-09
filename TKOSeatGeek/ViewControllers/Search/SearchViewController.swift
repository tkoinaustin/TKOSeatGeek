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
    provider.registerCells(for: self.tableView)

    tableView.dataSource = provider
    tableView.delegate = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    searchBar.delegate = self
    navigationController?.isNavigationBarHidden = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // make sure we have everything we need to perform segue
    guard let detailViewController = segue.destination as? DetailViewController else { return }
    guard let indexPath = sender as? IndexPath else { return }

    let image = (tableView.cellForRow(at: indexPath) as? SearchResultCell)?.mainImage.image
    let eventData = viewModel.events[indexPath.row]
    detailViewController.updateTableViewCell = { self.tableView.reloadRows(at: [indexPath], with: .fade) }
    detailViewController.setup(eventData, image: image)
  }
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.searchBar.endEditing(true)
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "detailViewSegue", sender: indexPath)
    }
  }
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchString = searchText
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
}
