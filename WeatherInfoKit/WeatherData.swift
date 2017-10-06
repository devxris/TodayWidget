//
//  WeatherData.swift
//  TodayWidget
//
//  Created by Chris Huang on 06/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

public struct WeatherData: Decodable {
	
	public struct Main: Decodable {
		public var temp: Double
	}
	public struct WeatherType: Decodable {
		public var description: String
	}
	
	public var main: Main?
	public var weather: [WeatherType]?
}
