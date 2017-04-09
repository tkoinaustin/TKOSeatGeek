//
//  SearchDataProvider.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit
import PromiseKit

class SearchDataProvider: NSObject, UITableViewDataSource {
  private let cellIdentifier = "SearchResultCell"
  weak var viewModel: SearchViewModel!
  
  func registerCells(for tableView: UITableView) {
    let resultsCell = String(describing: SearchResultCell.self)
    tableView.register(UINib(nibName: resultsCell, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.events.count ?? 0
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                             for: indexPath)
    
    if let cell = cell as? SearchResultCell {
      let event = viewModel.events[indexPath.row]
      cell.mainImage.image = nil
      cell.titleLabel.text = event.title
      cell.locationLabel.text = event.location
      cell.dateLabel.text = event.startDate
      loadImage(from: event.imageUrl).then { image -> Void in
        cell.mainImage.image = image
      }
    }
    cell.selectionStyle = .none
    
    return cell
  }
  
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
