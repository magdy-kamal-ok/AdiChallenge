//
//  MainScreenBuilder.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

public struct MainScreenBuilder {

    public static func viewController(coordinator: Coordinator) -> UIViewController {
        return AdiHomeViewController(viewModel: AdiHomeViewModel(homeRepository: HomeRepository(), coordinator: coordinator))
    }
}
