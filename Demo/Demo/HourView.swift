//
//  HourView.swift
//  Demo
//
//  Created by Bomidyala Swathi on 09/09/24.
//

import UIKit

class HourView: UIView {

    // MARK: Private Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()


    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let iconImageView: CachingImage = {
        let imageView = CachingImage()
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: Private Methods
    private func setupViews() {
        setupStackView()
        setupTimeLabel()
        setupIconImageView()
        setupTemperatureLabel()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupTimeLabel() {
        stackView.addArrangedSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupIconImageView() {
        stackView.addArrangedSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTemperatureLabel() {
        stackView.addArrangedSubview(temperatureLabel)
    }
    
    // MARK: Methods
    func setupData(time: String, iconImageUrl: String, temperature: String) {
        timeLabel.text = time
        iconImageView.loadImageWithUrl(urlString: iconImageUrl)
        temperatureLabel.text = temperature
    }
}
