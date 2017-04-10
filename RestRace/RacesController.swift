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
	
	@IBOutlet weak var bbMore: UIBarButtonItem!
	@IBOutlet weak var bbReload: UIBarButtonItem!
	
	@IBAction func btnMoreClicked(_ sender: Any) {
		self.loadMore()
	}
	@IBAction func btnReloadClicked(_ sender: Any) {
		self.reload()
	}
	
	var races = [Race]()
	
	var limit = 5
	var skip = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.loadMore()
	}
	
	func loadMore() {
		
		self.aiLoading.startAnimating()
		
		Api.sharedInstance.getRaces(limit: limit, skip: skip) { races, error in
			if error != nil {
				//handle error
				return
			}
			
			for race in (races?.items)! {
				self.races.append(race)
			}
			
			self.skip += self.limit
			
			DispatchQueue.main.async {
				self.bbMore.isEnabled = races?.next != nil
				self.tvRaces.reloadData()
				self.aiLoading.stopAnimating()
			}
		}
	}
	
	func reload() {
		skip = 0
		
		races = [Race]()
		loadMore()
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
		cell.accessoryType = .disclosureIndicator
		
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
