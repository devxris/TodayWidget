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
	
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
		
        completionHandler(NCUpdateResult.newData)
    }
    
}
