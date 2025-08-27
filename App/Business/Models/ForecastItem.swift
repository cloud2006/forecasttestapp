//
//  ForecastItem.swift
//  App
//
//

import Foundation

struct ForecastItem {
    let day: String
    let description: String
    let sunrise: Int
    let sunset: Int
    let chanceRain: Double
    let high: Int
    let low: Int
    let type: String
}

typealias ForecastItems = [ForecastItem]
