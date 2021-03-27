//
//  AdiHomeViewController.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class AdiHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoadingIndicator: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl?

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
        setupSwipeRefresh()
        setupViews()
        viewModel.fetchProducts()
    }
    

    
    private func setupViews() {
        if let navbar = navigationController?.navigationBar as? AdiNavigationBar {
            navbar.searchBar.placeholder = "search-bar-placeholder".localized
            navbar.searchBar.delegate = self
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.registerCellNib(cellClass: HomeProductTableViewCell.self)
        
        viewModel.state.reloadData.bind(on: self) { (self, _) in
            DispatchQueue.main.async {
                self.checkRefreshControlState()
                self.tableView.reloadData()
            }
        }
        
        viewModel.state.isLoading.bind(on: self) { (self, isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self.activityLoadingIndicator.startAnimating()
                } else {
                    self.activityLoadingIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.state.showAlert.bind(on: self) { (self, adiAlertModel) in
            DispatchQueue.main.async {
                self.showAlertOk(title: adiAlertModel.title, message: adiAlertModel.message)
            }
        }
    }

    // MARK: Refresh cotrol
    func setupSwipeRefresh() -> Void {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        refreshControl?.addTarget(self, action: #selector(swipeRefreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }

    @objc func swipeRefreshTableView() {
        viewModel.fetchProducts()
    }
    
    func startRefreshTableView() {
        refreshControl?.beginRefreshing()
    }
    
    func endRefreshTableView() -> Void {
        self.refreshControl?.endRefreshing()
    }

    func checkRefreshControlState() -> Void {
        DispatchQueue.main.async {
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
}

extension AdiHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeProductTableViewCell
        cell.productInfo = viewModel.products[indexPath.row]
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
