//
//  DetailTableViewCell.swift
//  History of weather
//
//  Created by Bogdan Deshko on 1/21/19.
//  Copyright © 2019 Bogdan Deshko. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var afDays: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var rain: UILabel!
    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    func configure(_ model: WeatherData, _ month: String) {
        minTemperature.text = model.minTemperature
        maxTemperature.text = model.maxTemperature
        afDays.text = model.afDays
        rain.text = model.rain
        sun.text = model.sunHours
        monthLabel.text = month
    }
}
