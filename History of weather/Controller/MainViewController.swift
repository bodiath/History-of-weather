//  MainViewController.swift
//  History of weather
//
//  Created by Bogdan Deshko on 1/18/19.
//  Copyright © 2019 Bogdan Deshko. All rights reserved.

import UIKit

class MainViewController: UITableViewController {
    private var mainString = ""
    private var sortedWeatherData = [[WeatherData]]()
    private var weatherData = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History of Weather"
        loadText()
    }
    
    func loadText() {
        let textUrl: URL = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")!
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            if let data = try? Data(contentsOf: textUrl) {
                self.mainString = String(data: data, encoding: .utf8)!
                var row = self.mainString.components(separatedBy: "\n") as [String]
                for i in 7..<row.count {
                    let separatedRow = row[i].split(separator: " ")
                    self.weatherData.append(WeatherData(year: String(separatedRow[0]),
                                                        month: String(separatedRow[1]),
                                                        maxTemperature: String(separatedRow[2]),
                                                        minTemperature: String(separatedRow[3]),
                                                        afDays: String(separatedRow[4]),
                                                        rain: String(separatedRow[5]),
                                                        sunHours: String(separatedRow[6])))
                }
                self.sortedWeatherData = self.weatherData.chunked(into: 12)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedWeatherData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.sortedWeatherData[indexPath.row][0].year
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueIdentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.weatherData = sortedWeatherData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
