//
//  HoursScrollView.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import UIKit

class HoursScrollView: UIScrollView {

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
    }

    private func setupScrollView() {
        showsHorizontalScrollIndicator = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5.0
    }
    
    func addHourViewsToScrollView(hours: [Hour]) {
        let itemHeight = 100
        let itemWidth = 100
        
        for i in 0..<hours.count {
            let hourObject = hours[i]
            let hourView = HourView()
            hourView.frame = CGRect(x: Int(i) * itemWidth, y: 0, width: itemWidth, height: itemHeight)
            hourView.setupData(time: hourObject.time.getDate()?.getHour() ?? "", iconImageUrl: hourObject.condition.icon.getUrl(), temperature: hourObject.tempF.toString)
            addSubview(hourView)
        }
        
        // Update scroll view content size
        let contentWidth = hours.count * itemWidth
        contentSize = CGSize(width: contentWidth, height: itemHeight)
    }
}
