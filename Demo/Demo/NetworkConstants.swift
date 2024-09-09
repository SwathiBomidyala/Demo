//
//  NetworkConstants.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation


enum NetworkConstants {
    static let version = "v1"
    static let url = "https://api.weatherapi.com/"

    static var baseUrl: String {
        return url + version
    }
}
