//
//  ForecastNetworkService.swift
//  App
//
//

import Combine

protocol ForecastNetworkService {
    
    func getForecast() -> AnyPublisher<ForecastItems, Error>

    func getForecast() async throws -> ForecastItems
}
