//
//  ListViewCoordinator.swift
//  App
//
//

import UIKit

class ListViewCoordinator {

    weak var navigationController: UINavigationController?
    private weak var viewController: ListViewController?
    private var detailCoordinator: DetailViewCoordinator?

    public func start(window: UIWindow) {
        let viewModel = ListViewModel()

        // TODO
        //  viewModel.showDetail =
        // my implementation of showDetails.
        viewModel.showDetail = { [weak self] item in
            self?.showDetails(for: item)
        }

        let viewController = ListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
        self.viewController = viewController
    }

    private func showDetails(for item: ForecastItem) {
        let coordinator = DetailViewCoordinator(navigationController: navigationController)
        self.detailCoordinator = coordinator
        coordinator.start(with: item)
    }
}
