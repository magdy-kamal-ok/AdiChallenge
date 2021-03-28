//
//  ProductDetailsViewController.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

enum ProductDetailsSection {
    case productInfo
    case productReviews([ProductReview])

    var rowsList: [Any] {
        switch self {
        case .productInfo:
            return []
        case .productReviews(let list):
            return list
        }
    }
    var count: Int {
        switch self {
        case .productInfo:
            return 0
        case .productReviews(let list):
            return list.count
        }
    }
}

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoadingIndicator: UIActivityIndicatorView!
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
    
    deinit {
        print("deinit called")
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 25
        tableView.registerCellNib(cellClass: ProductReviewTableViewCell.self)
        tableView.registerHeaderNib(headerClass: ProductDetailsHeaderView.self)
        tableView.registerHeaderNib(headerClass: ProductReviewsHeaderView.self)
        viewModel.state.showAddNewReview.bind(on: self) { (self, _) in
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
        
        viewModel.state.reloadData.bind(on: self) { (self, _) in
            DispatchQueue.main.async {
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
    
    private func showAlert() {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let reviewView = ReviewView()
        reviewView.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(reviewView)
        reviewView.translatesAutoresizingMaskIntoConstraints = false
        reviewView.topAnchor.constraint(equalTo: alertController.view.topAnchor).isActive = true
        reviewView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor).isActive = true
        reviewView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor).isActive = true
        reviewView.heightAnchor.constraint(equalToConstant: 200).isActive = true

            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        alertController.addAction(UIAlertAction(title: "submit".localized, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.didPressSubmitReview(text: reviewView.reviewText, rating: reviewView.ratingValue)
            
        }))
        alertController.hideKeyboardWhenTappedAround()
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionList[indexPath.section] {
        case .productReviews(let reviews):
            let cell = tableView.dequeue() as ProductReviewTableViewCell
            cell.productReview = reviews[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sectionList[section] {
        case .productInfo:
            let headerView = tableView.dequeueHeader() as ProductDetailsHeaderView
            productDetailsHeaderView = headerView
            headerView.productInfo = viewModel.productInfo
            return headerView
        case .productReviews:
            let headerView = tableView.dequeueHeader() as ProductReviewsHeaderView
            headerView.didPressAddNewReview.bind(on: self) { (self, _) in
                self.viewModel.didPressAddNewReview()
            }
            return headerView
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
    }
}
