//
//  ForecastNetworkServiceImpl.swift
//  App
//
//

import Foundation
import Combine

class ForecastNetworkServiceImpl: ForecastNetworkService {

    private let url = URL(string: "https://gist.githubusercontent.com/KDVL/e7f029dacebeefb2b7ce8ffdfe2d2315/raw/e013e1dc3fa649c003810ffa3acd7f57c405b217/forecast.json")!

    func getForecast() -> AnyPublisher<ForecastItems, Error> {

        return URLSession(configuration: .default)
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: [ForecastItemDTO].self, decoder: JSONDecoder())
            .map{ $0.map { $0.toDomain() }}
            .eraseToAnyPublisher()
    }

    func getForecast() async throws -> ForecastItems {

        let (data, _) = try await URLSession.shared.data(from: url)
        let dtos = try JSONDecoder().decode([ForecastItemDTO].self, from: data)
        return dtos.map { $0.toDomain() }
    }
}
