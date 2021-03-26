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
    }

    private weak var coordinator: ProductDetailsCoordinator?

    private(set) var product: Product
    
    var state: State
    
    //
    // MARK: Initializer
    //
    init(product: Product, coordinator: Coordinator) {
        self.coordinator = coordinator as? ProductDetailsCoordinator
        self.product = product
        state = State(isLoading: Binder(), showAddNewReview: Binder())
    }
    
    func cancelDatatRequest() {
        
    }
    
    private func observeRepositoryResult() {
        state.isLoading(true)
        
    }
    
    public func fetchProducts() {
        observeRepositoryResult()
    }
    
    public func didSelectItem(at index: Int) {
        
    }
}
