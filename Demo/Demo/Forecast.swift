//
//  Forecast.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

struct Forecast: Codable {
    let forecastday: [ForecastDay]

    enum CodingKeys: String, CodingKey {
        case forecastday = "forecastday"
    }
}
