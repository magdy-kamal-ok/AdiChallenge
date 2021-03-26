//
//  ProductDetailsViewController.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var productDetailsHeaderView: ProductDetailsHeaderView?
    
    private let viewModel: ProductDetailsViewModel
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProductDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.registerCellNib(cellClass: HomeProductTableViewCell.self)
        tableView.registerHeaderNib(headerClass: ProductDetailsHeaderView.self)
        tableView.registerHeaderNib(headerClass: ProductReviewsHeaderView.self)

    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Start Chat with Comma Separated user id", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            guard let userIds = alert.textFields?.first?.text else { return }
            let separatedUserIds = userIds.split(separator: ",").map(String.init)
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true, completion: nil)
    }
}


extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HomeProductTableViewCell
        cell.productDescLabel.text = "viewModel.products[indexPath.row].productDescription"
        cell.productNameLabel.text = "viewModel.products[indexPath.row].name"
        cell.productPriceLabel.text = "(viewModel.products[indexPath.row].price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueHeader() as ProductDetailsHeaderView
            productDetailsHeaderView = headerView
            headerView.productDescLabel.text = viewModel.product.productDescription
            headerView.productNameLabel.text = viewModel.product.name
            headerView.productPriceLabel.text = "\(viewModel.product.price)"
            headerView.productImageView.loadImageUsingUrlString(urlString: viewModel.product.imgURL, placeHolderImage: nil)
            return headerView
        } else if section == 1 {
            let headerView = tableView.dequeueHeader() as ProductReviewsHeaderView
            headerView.didPressAddNewReview.bind(on: self) { (self, _) in
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
            return headerView
        } else {
            return nil
        }
    }
}

extension ProductDetailsViewController: ZoomTransitionAnimating {
    var transitionSourceImageView: UIImageView {
        let imageView = UIImageView(image: productDetailsHeaderView?.productImageView.image)
        imageView.contentMode = productDetailsHeaderView?.productImageView.contentMode ?? .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = productDetailsHeaderView?.productImageView.frame ?? .zero
        return imageView;
    }

    var transitionSourceBackgroundColor: UIColor? {
        return view.backgroundColor
    }

    var transitionDestinationImageViewFrame: CGRect {
        let width = view.frame.width
        var frame = productDetailsHeaderView?.productImageView.frame
        frame?.size.width = width
        return frame ?? CGRect.zero
    }
}

extension ProductDetailsViewController: ZoomTransitionDelegate {
    func zoomTransitionAnimator(animator: ZoomTransitionAnimator,
        didCompleteTransition didComplete: Bool,
        animatingSourceImageView imageView: UIImageView) {
        productDetailsHeaderView?.productImageView.image = imageView.image
        productDetailsHeaderView?.productNameLabel.text = viewModel.product.name
        productDetailsHeaderView?.productPriceLabel.text = "\(viewModel.product.price)"
        productDetailsHeaderView?.productDescLabel.text = viewModel.product.productDescription
    }
}
