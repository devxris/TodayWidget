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
	
	var defaults = UserDefaults(suiteName: "group.com.DevXris.TodayWidgetGroup")!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		cityLabel.text = location
		
		// get weather data from WeatherInfoKit initially
		WeatherService.shared.getCurrentWeather(at: location) { (data) in
			guard let temp = data?.main?.temp, let desc = data?.weather?[0].description else { return }
			DispatchQueue.main.async {
				self.weatherLabel.text = desc
				self.temperatureLabel.text = String(format: "%.1f", temp) + "\u{00B0}"
			}
		}
	}
	
	// update widget when it's off-screen
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
		
		// get location from userDefaults
		if let defaultLocation = defaults.value(forKey: "location") as? String {
			location = defaultLocation
		}
		cityLabel.text = location
		
		WeatherService.shared.getCurrentWeather(at: location) { (data) in
			guard let data = data else { completionHandler(NCUpdateResult.noData); return }
			guard let temp = data.main?.temp, let desc = data.weather?[0].description else { completionHandler(NCUpdateResult.noData); return }
			DispatchQueue.main.async {
				self.weatherLabel.text = desc
				self.temperatureLabel.text = String(format: "%.1f", temp) + "\u{00B0}"
			}
		}
        completionHandler(NCUpdateResult.newData)
    }
}
