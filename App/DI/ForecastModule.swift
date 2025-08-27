//
//  ForecastModule.swift
//  App
//
//  Created by Pavlo Antoniuk on 26.08.2025.
//

import Global
import Swinject

struct ForecastModule: Module {

    func registerServices() {
        let container = GlobalContainer.defaultContainer

        container.register(ForecastNetworkService.self) { _ in
            ForecastNetworkServiceImpl()
        }
        .inObjectScope(.container)

        container.register(ForecastService.self) { resolver in
            let network = resolver.resolve(ForecastNetworkService.self)!
            return ForecastServiceImpl(network: network)
        }
        .inObjectScope(.container)
    }
}
