//
//  DateUtils.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import Foundation

extension Date {
    //Good to Have: We can maintain date format constants in separate file.
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: self)
    }

    func getHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        return dateFormatter.string(from: self).lowercased()
    }

}
