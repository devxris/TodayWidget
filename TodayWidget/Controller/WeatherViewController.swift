//
//  WeatherViewController.swift
//  TodayWidget
//
//  Created by Chris Huang on 06/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	
	var city = "Paris"
	var country = "France"

	override func viewDidLoad() {
		super.viewDidLoad()
		
		weatherLabel.text = ""
		temperatureLabel.text = ""
		
		displayCurrentWeather()
	}
	
	private func displayCurrentWeather() {
		cityLabel.text = city
		countryLabel.text = country
		
		WeatherService.shared.getCurrentWeather(at: city + "," + country) { (data) in
			guard let temp = data?.main?.temp, let desc = data?.weather?[0].description else { return }
			DispatchQueue.main.async {
				self.weatherLabel.text = desc.capitalized
				self.temperatureLabel.text = String(format: "%.1f", temp) + "\u{00B0}"
			}
		}
	}
	
	// MARK: - Action methods
	
	@IBAction func unwindToHome(segue: UIStoryboardSegue) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
		guard let sourceVC = segue.source as? LocationTableViewController else { return }
		var selectedLocation = sourceVC.selectedLocation.characters.split { $0 == "," }.map { String($0) }
		city = selectedLocation[0]
		country = selectedLocation[1].trimmingCharacters(in: .whitespacesAndNewlines)
		
		displayCurrentWeather()
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		// Get the new view controller using [segue destinationViewController].
		// Pass the selected object to the new view controller.
		if segue.identifier == "ShowLocations" {
			if let destinationVC = segue.destination as? UINavigationController {
				if let locationTableViewController = destinationVC.viewControllers[0] as? LocationTableViewController {
					locationTableViewController.selectedLocation = "\(city), \(country)"
				}
			}
		}
	}
}

