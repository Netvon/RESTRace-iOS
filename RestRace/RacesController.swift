//
//  RacesController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 08/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import UIKit


class RacesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tvRaces: UITableView!
	@IBOutlet weak var aiLoading: UIActivityIndicatorView!
	
	var races = [Race]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		Api.sharedInstance.getRaces { races, error in
			if error != nil {
				//handle error
				return
			}
			
			self.races = (races?.items)!
			
			DispatchQueue.main.async {
				self.tvRaces.reloadData()
				self.aiLoading.stopAnimating()
			}
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showRaceDetail", sender: self)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return races.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
		
		cell.textLabel?.text = races[indexPath.row].name
		cell.detailTextLabel?.text = races[indexPath.row].description
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showRaceDetail" {
			if let indexPath = tvRaces.indexPathForSelectedRow {
				let controller = segue.destination as! RaceController
				controller.race = races[indexPath.row]
			}
		}
	}
	
}
