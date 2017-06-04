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
  
  @IBOutlet fileprivate weak var searchBar: UISearchBar! { didSet {
    searchBar.showsCancelButton = true
    searchBar.placeholder = "Whatcha lookin' for?"
  }}
  
  @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.updateUI = {
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
    }
    viewModel.showError = showConnectionProblems
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

    let eventData = viewModel.events[indexPath.row]
    let image = eventData.imageUrl == nil ?
      nil :
      (tableView.cellForRow(at: indexPath) as? SearchResultCell)?.mainImage.image
    detailViewController.updateTableViewCell = { self.tableView.reloadRows(at: [indexPath], with: .fade) }
    detailViewController.setup(eventData, image: image)
  }
  
  func showConnectionProblems(_ desc: String) {
    let alertViewController = UIAlertController(title: "Error", message: desc, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel)
    alertViewController.addAction(action)
    
    self.searchBar.endEditing(true)
    self.present(alertViewController, animated: true)
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
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.activityIndicator.startAnimating()
    viewModel.searchForEvents()
    searchBar.endEditing(true)
  }
}
