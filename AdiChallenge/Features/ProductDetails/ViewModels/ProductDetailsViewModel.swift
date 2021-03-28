//
//  ProductDetailsViewModel.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import Foundation

class ProductDetailsViewModel {
    struct State {
        let isLoading: Binder<Bool, Void>
        let showAddNewReview: Binder<Void, Void>
        let reloadData: Binder<Void, Void>
        let showAlert: Binder<AdiAlertModel, Void>
    }

    private weak var coordinator: ProductDetailsCoordinator?
    private var product: Product
    private let postReview: PostReviewProtocol
    private(set) var sectionList: [ProductDetailsSection] = []
    
    var productInfo: ProductPresentationModel {
        get {
             ProductPresentationModel.init(product: product)
        }
    }
    
    var state: State
    
    //
    // MARK: Initializer
    //
    init(product: Product, coordinator: Coordinator?, postReview: PostReviewProtocol) {
        self.postReview = postReview
        self.coordinator = coordinator as? ProductDetailsCoordinator
        self.product = product
        sectionList.append(.productInfo)
        sectionList.append(.productReviews(product.reviews.map { ProductReview(review: $0) }))
        state = State(isLoading: Binder(), showAddNewReview: Binder(), reloadData: Binder(), showAlert: Binder())
    }
    
    func cancelDatatRequest() {
        
    }
    
    public func didPressAddNewReview() {
        state.showAddNewReview(())
    }
    
    public func didPressSubmitReview(text: String, rating: Int) {
        state.isLoading(true)
        postReview.postReview(params: ["text": text, "rating": rating]) { [weak self] result in
            guard let self = self else { return }
            defer { self.state.isLoading(false);  self.state.reloadData(()) }
            switch result {
            case .success(let review):
                self.product.reviews.append(review)
                if let reviewsSectionIndex = self.sectionList.firstIndex(where: { if case .productReviews = $0 { return true }; return false }) {
                    self.sectionList[reviewsSectionIndex] = .productReviews(self.product.reviews.map { ProductReview(review: $0) })
                }
            case .failure(let error):
                self.state.showAlert(AdiAlertModel(title: "error".localized, message: error.message))
            }
        }
    }
}
