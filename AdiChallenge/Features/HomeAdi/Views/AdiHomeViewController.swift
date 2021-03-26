//
//  AdiHomeViewController.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class AdiHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let viewModel: AdiHomeViewModel
    
    init(viewModel: AdiHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AdiHomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchProducts()
    }
    
    private func setupViews() {
        if let navbar = navigationController?.navigationBar as? AdiNavigationBar {
            navbar.searchBar.delegate = self
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: HomeProductTableViewCell.self)
        
        viewModel.state.reloadData.bind(on: self) { (self, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.state.isLoading.bind(on: self) { (self, isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

}

extension AdiHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.homeProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeProductTableViewCell
        cell.homeProduct = viewModel.homeProducts[indexPath.row]
        return cell
    }
}

extension AdiHomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}


extension AdiHomeViewController: ZoomTransitionAnimating, ZoomTransitionDelegate {
    var transitionSourceImageView: UIImageView {
        if let selectedIndexPath = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: selectedIndexPath) as? HomeProductTableViewCell {
            let imageView = UIImageView(image: cell.productImageView.image)
            imageView.contentMode = cell.productImageView.contentMode;
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = false
            var frameInSuperview = cell.productImageView.convert(cell.productImageView.frame, to: tableView.superview)
            frameInSuperview.origin.x -= 8 // Left margin of ImageView from Cell
            frameInSuperview.origin.y -= 8 // Top margin of ImageView from Cell
            imageView.frame = frameInSuperview
            return imageView

        } else {
            return UIImageView.init()
        }
    }

    var transitionSourceBackgroundColor: UIColor? {
        return tableView.backgroundColor
    }

    var transitionDestinationImageViewFrame: CGRect {
        if let selectedIndexPath = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: selectedIndexPath) as? HomeProductTableViewCell {
            var frameInSuperview = cell.productImageView.convert(cell.productImageView.frame, to: tableView.superview)
            frameInSuperview.origin.x -= 8 // Left margin of ImageView from Cell
            frameInSuperview.origin.y -= 8 // Top margin of ImageView from Cell
            return frameInSuperview
        } else {
            return CGRect.zero
        }
    }
}
