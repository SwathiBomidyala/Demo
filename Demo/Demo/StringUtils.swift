//
//  StringUtils.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

extension String {
    func getUrl() -> String {
        return String(format: "https:\(self)")
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: self)
    }
}
