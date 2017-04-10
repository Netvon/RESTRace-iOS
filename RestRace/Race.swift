//
//  Races.swift
//  RestRace
//
//   08/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class Race: ModelBase {
	
	let isError = false
	
	enum RaceStatus: String {
		case notStarted = "notstarted"
		case started = "started"
		case ended = "ended"
	}
	
	let id: String
	let name: String
	var description: String? = nil
	let status: RaceStatus
	let starttime: Date
	var tags: [String] = []
	var pubs: [Pub] = []
	var teams: [Team] = []
	
	required init?(json: [String : Any]) {
		guard let id = json["_id"] as? String,
			let name = json["name"] as? String,
			let status = json["status"] as? String,
			let starttime = json["starttime"] as? String
			
			else {
				return nil
		}
		
		self.id = id
		self.name = name
		self.description = json["description"] as? String
		self.tags = json["tags"] as! [String]
		self.status = RaceStatus.init(rawValue: status)!
		self.starttime = Api.sharedInstance.date(from: starttime)
		
		let jsonPubs = json["pubs"] as? [[String: Any]]
		
		if jsonPubs != nil {
			for pub in jsonPubs! {
				let newPub = Pub(json: pub)
				
				if newPub != nil {
					pubs.append(Pub(json: pub)!)
				}
			}
		}
		
		let jsonTeams = json["teams"] as? [[String: Any]]
		
		if jsonTeams != nil {
			for team in jsonTeams! {
				let newTeam = Team(json: team)
				
				if newTeam != nil {
					teams.append(Team(json: team)!)
				}
			}
		}
		
	}
	
}
