//
//  LocationTableViewController.swift
//  TodayWidget
//
//  Created by Chris Huang on 06/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {

	var defualts = UserDefaults(suiteName: "group.com.DevXris.TodayWidgetGroup")!
	
	let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia", "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong", "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada"]
	var selectedLocation = "Paris, France"
	
	override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return locations.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = locations[indexPath.row]
		cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .checkmark : .none
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .checkmark
		if let location = cell?.textLabel?.text {
			selectedLocation = location
			defualts.set(selectedLocation, forKey: "location")
		}
		tableView.reloadData()
	}
}
