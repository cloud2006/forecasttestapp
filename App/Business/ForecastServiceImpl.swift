//
//  ForecastServiceImpl.swift
//  App
//
//  Created by Pavlo Antoniuk on 26.08.2025.
//
import Combine
import Foundation

final class ForecastServiceImpl: ForecastService {
    var items: CurrentValueSubject<ForecastItems, Never> = .init([])

    var network: ForecastNetworkService

    private var bag = Set<AnyCancellable>()

    init(network: ForecastNetworkService) {
        self.network = network
        fetchData()
    }

    func fetchData() {
        network.getForecast()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        // to simplify test we use just print. In the future here should be normal error handling
                        print("Forecast error:", error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] value in
                    self?.items.send(value)
                }
            )
            .store(in: &bag)
    }
}
