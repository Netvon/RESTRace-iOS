//
//  TeamController.swift
//  RestRace
//
//   09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

import UIKit


class TeamController: UIViewController, UITableViewDataSource {
	var team: Team?
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Owner"
		}
		
		return "Members"
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}
		
		return (team?.users.count)!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = UITableViewCell(style: .default, reuseIdentifier: "owner")
			cell.textLabel?.text = team?.owner?.username
			return cell
		} else {
			let cell = UITableViewCell(style: .default, reuseIdentifier: "member")
			cell.textLabel?.text = team?.users[indexPath.row].username
			return cell
		}
	}

}
