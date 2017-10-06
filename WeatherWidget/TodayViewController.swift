//
//  TodayViewController.swift
//  WeatherWidget
//
//  Created by Chris Huang on 06/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
	
	@IBOutlet var cityLabel:UILabel!
	@IBOutlet var weatherLabel:UILabel!
	@IBOutlet var temperatureLabel:UILabel!
	
	var location = "Paris, France"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		cityLabel.text = location
		
		// get weather data from WeatherInfoKit initially
		WeatherService.shared.getCurrentWeather(at: location) { (data) in
			DispatchQueue.main.async {
				guard let temp = data?.main?.temp, let desc = data?.weather?[0].description else { return }
				self.updateUI(desc: desc, temp: temp)
			}
		}
	}
	
	// update widget when it's off-screen
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
		
		cityLabel.text = location
		
		WeatherService.shared.getCurrentWeather(at: location) { (data) in
			guard let data = data else { completionHandler(NCUpdateResult.noData); return }
			guard let temp = data.main?.temp, let desc = data.weather?[0].description else { completionHandler(NCUpdateResult.noData); return }
			self.updateUI(desc: desc, temp: temp)
		}
        completionHandler(NCUpdateResult.newData)
    }
	
	private func updateUI(desc: String, temp: Double) {
		weatherLabel.text = desc
		temperatureLabel.text = String(format: "%d", temp) + "\u{00B0}"
	}
}
