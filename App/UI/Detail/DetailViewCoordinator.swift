//
//  DetailViewCoordinator.swift
//  App
//
//
import UIKit
import Foundation

class DetailViewCoordinator {
    
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start(with item: ForecastItem) {
        let vm = DetailViewModel(item: item)
        let vc = DetailViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
