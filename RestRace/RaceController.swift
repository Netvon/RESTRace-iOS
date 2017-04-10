//
//  RaceController.swift
//  RestRace
//
//   09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

import UIKit
import EventKit


class RaceController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	var race: Race?
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var tvInfo: UITableView!
	
	override func viewDidLoad() {
		if race != nil {
			niTitle.title = race?.name
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		tvInfo.reloadData()
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
				cell.accessoryType = .disclosureIndicator
			} else {
				cell.textLabel?.text = race?.starttime.description(with: Locale.current)
				cell.detailTextLabel?.text = "Start Time"
				cell.accessoryType = .disclosureIndicator
			}
			
			return cell
			
		case 1:
			let cell = UITableViewCell(style: .default, reuseIdentifier: "tagCell")
			cell.textLabel?.text = race?.tags[indexPath.row] ?? "none"
			return cell
		case 2:
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "teamCell")
			cell.textLabel?.text = race?.teams[indexPath.row].name
			cell.accessoryType = .disclosureIndicator
			
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
			cell.accessoryType = .disclosureIndicator
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
		} else if indexPath.section == 0 && indexPath.row == 1 {
			self.createCallEvent()
		} else if indexPath.section == 0 && indexPath.row == 0 {
			self.performSegue(withIdentifier: "showEditDescription", sender: self)
		}
	}
	
	func createCallEvent() {
		
		let eventStore: EKEventStore = EKEventStore()
		
		eventStore.requestAccess(to: .event) { (granted, error) in
			
			if (granted) && (error == nil) {
				print("granted \(granted)")
				print("error \(error)")
				
				let event:EKEvent = EKEvent(eventStore: eventStore)
				
				event.title = (self.race?.name)!
				event.startDate = (self.race?.starttime)!
				event.endDate = event.startDate.addingTimeInterval(TimeInterval(1 * 60 * 60))
				event.calendar = eventStore.defaultCalendarForNewEvents
				event.notes = self.race?.description
				
				do {
					try eventStore.save(event, span: .thisEvent)
				} catch let error as NSError {
					DispatchQueue.main.async {
						self.showError(error: error)
					}
				}
				
				DispatchQueue.main.async {
					self.showMessage(message: "Event saved to calendar")
				}
			}
			else{
				
				DispatchQueue.main.async {
					self.showError(error: error!)
				}
			}
		}
	}
	
	func showMessage(message: String) {
		let alert = UIAlertController(title: "Added Event", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func showError(error: Error) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
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
		} else if segue.identifier == "showEditDescription" {
			let controller = segue.destination as! EditRaceController
			controller.race = race
		}
 	}
}
