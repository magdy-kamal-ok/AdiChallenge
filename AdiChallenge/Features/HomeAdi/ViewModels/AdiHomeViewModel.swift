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
        let showAlert: Binder<AdiAlertModel, Void>
    }

    private let homeRepository: HomeRepositoryProtocol
    private weak var coordinator: MainScreenCoordinator?
    private var allAvailableProducts: [Product] = []
    
    var searchText: String = "" {
        didSet {
            state.reloadData(())
        }
    }
    
    var products: [ProductPresentationModel] {
        get {
            if searchText.isEmpty {
                return allAvailableProducts.map { ProductPresentationModel.init(product: $0) }
            } else {
                return allAvailableProducts.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.productDescription.lowercased().contains(searchText.lowercased())}.map { ProductPresentationModel(product: $0) }
            }
        }
    }
    
    var state: State
    
    //
    // MARK: Initializer
    //
    init(homeRepository: HomeRepositoryProtocol, coordinator: Coordinator?) {
        self.coordinator = coordinator as? MainScreenCoordinator
        self.homeRepository = homeRepository
        state = State(isLoading: Binder(), reloadData: Binder(), showAlert: Binder())
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
                self.allAvailableProducts = products
            case .failure(let error):
                self.state.showAlert(AdiAlertModel(title: "error".localized, message: error.message))
            }
        }
    }
    
    public func fetchProducts() {
        observeRepositoryResult()
    }
    
    public func didSelectItem(at index: Int) {
        if let productIndex = allAvailableProducts.indices.first(where: { allAvailableProducts[$0].id == products[index].id && allAvailableProducts[$0].name == products[index].name }) {
            coordinator?.showProductDetails(product: allAvailableProducts[productIndex])
        }
        
    }
}
