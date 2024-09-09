//
//  WeatherResponse.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
}
