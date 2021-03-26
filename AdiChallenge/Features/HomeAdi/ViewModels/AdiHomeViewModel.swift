//
//  AdiHomeViewModel.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation

class AdiHomeViewModel {
    struct State {
        let isLoading: Binder<Bool, Void>
        let reloadData: Binder<Void, Void>
    }

    private let homeRepository: HomeRepositoryProtocol
    private weak var coordinator: MainScreenCoordinator?

    private var products: [Product] = []
    var searchText: String = "" {
        didSet {
            state.reloadData(())
        }
    }
    
    var homeProducts: [HomeProductModel] {
        get {
            if searchText.isEmpty {
                return products.map { HomeProductModel(id: $0.id, name: $0.name, image: $0.imgURL, price: "\($0.price)" + $0.currency, description: $0.productDescription) }
            } else {
                return products.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.productDescription.lowercased().contains(searchText.lowercased())}.map { HomeProductModel(id: $0.id, name: $0.name, image: $0.imgURL, price: "\($0.price)" + $0.currency, description: $0.productDescription) }
            }
        }
    }
    
    
    var state: State
    
    //
    // MARK: Initializer
    //
    init(homeRepository: HomeRepositoryProtocol, coordinator: Coordinator) {
        self.coordinator = coordinator as? MainScreenCoordinator
        self.homeRepository = homeRepository
        state = State(isLoading: Binder(), reloadData: Binder())
    }
    
    func cancelDatatRequest() {
        homeRepository.cancelRequest()
    }
    
    private func observeRepositoryResult() {
        state.isLoading(true)
        homeRepository.fetchProducts() { [weak self] result in
            guard let self = self else { return }
            defer { self.state.isLoading(false);  self.state.reloadData(()) }
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                break
            }
        }
    }
    
    public func fetchProducts() {
        observeRepositoryResult()
    }
    
    public func didSelectItem(at index: Int) {
        coordinator?.showProductDetails(product: products[index])
    }
}
