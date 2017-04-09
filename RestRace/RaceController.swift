//
//  RaceController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

import UIKit


class RaceController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	var race: Race?
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var tvInfo: UITableView!
	
	override func viewDidLoad() {
		if race != nil {
			niTitle.title = race?.name
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch(section) {
		case 0:
			return 2
		case 1:
			return (race?.tags.count)!
		case 2:
			return (race?.teams.count)!
		case 3:
			return (race?.pubs.count)!
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch(section) {
		case 0:
			return "Details"
		case 1:
			return "Tags"
		case 2:
			return "Teams"
		case 3:
			return "Pubs"
		default:
			return ""
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch(indexPath.section) {
		case 0:
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "detailCell")
			
			if indexPath.row == 0 {
				cell.textLabel?.text = race?.description
				cell.detailTextLabel?.text = "Description"
			} else {
				cell.textLabel?.text = race?.starttime.description(with: Locale.current)
				cell.detailTextLabel?.text = "Start Time"
			}
			
			return cell
			
		case 1:
			let cell = UITableViewCell(style: .default, reuseIdentifier: "tagCell")
			cell.textLabel?.text = race?.tags[indexPath.row] ?? "none"
			return cell
		case 2:
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "teamCell")
			cell.textLabel?.text = race?.teams[indexPath.row].name
			
			let count = (race?.teams[indexPath.row].users.count)!
			if count == 1 {
				cell.detailTextLabel?.text = "\(count) member"
			} else {
				cell.detailTextLabel?.text = "\(count) members"
			}
			
			return cell
		case 3:
			let cell = UITableViewCell(style: .default, reuseIdentifier: "pubCell")
			cell.textLabel?.text = race?.pubs[indexPath.row].name
			return cell
		default:
			return UITableViewCell(style: .default, reuseIdentifier: "cell")
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 3 {
			self.performSegue(withIdentifier: "showPubDetail", sender: self)
		} else if indexPath.section == 2 {
			self.performSegue(withIdentifier: "showTeamDetail", sender: self)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showPubDetail" {
			if let indexPath = tvInfo.indexPathForSelectedRow {
				let controller = segue.destination as! PubController
				controller.pub = race?.pubs[indexPath.row]
			}
		} else if segue.identifier == "showTeamDetail" {
			if let indexPath = tvInfo.indexPathForSelectedRow {
				let controller = segue.destination as! TeamController
				controller.team = race?.teams[indexPath.row]
			}
		}
	}
}
