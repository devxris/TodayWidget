//
//  WeatherService.swift
//  TodayWidget
//
//  Created by Chris Huang on 06/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

public class WeatherService {
	
	private let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=54966031ac95a147973ed2629bf464da&units=metric&q="
	private let urlSession = URLSession.shared
	
	public static let shared = WeatherService()
	
	public typealias DataCompletion = (_ data: WeatherData?) -> ()
	
	public func getCurrentWeather(at location: String, completion: @escaping DataCompletion) {
		
		let openWeatherAPI = openWeatherBaseAPI + location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
		print(openWeatherAPI)
		
		guard let queryURL = URL(string: openWeatherAPI) else { return }
		let request = URLRequest(url: queryURL)
		var weatherData = WeatherData()
		let task = urlSession.dataTask(with: request) { (data, response, error) in
			guard let data = data else { if let error = error { print(error.localizedDescription) }; return }
			do {
				weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
				completion(weatherData)
			} catch let fetchError {
				print(fetchError.localizedDescription)
			}
		}
		task.resume()
	}
}
