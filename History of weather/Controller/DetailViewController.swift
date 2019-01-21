//
//  DetailViewController.swift
//  History of weather
//
//  Created by Bogdan Deshko on 1/20/19.
//  Copyright © 2019 Bogdan Deshko. All rights reserved.

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let month = ["January","Febrary","March","April","May","June","July",
                 "August","September","October","November","December"]
    public var weatherData: [WeatherData] = []
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weatherData[0].year
        let nibName = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "detailCellIdentifier")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailTableViewCell
        cell.configure(weatherData[indexPath.row], self.month[indexPath.row])
        return cell
    }
}
