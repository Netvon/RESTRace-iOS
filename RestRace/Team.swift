//
//  Team.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

struct Team: ModelBase {
	
	let isError = false
	
	let id: String
	let name: String
	var endTime: Date? = nil
	
	var rankings: [Ranking] = []
	var users: [User] = []
	
	var owner: User? = nil
	
	init?(json: [String : Any]) {
		guard let id = json["_id"] as? String,
			let name = json["name"] as? String
			else {
				return nil
		}
		
		self.id = id
		self.name = name
		let endTime = json["endtime"] as? String
		
		if endTime != nil {
			self.endTime = Api.sharedInstance.date(from: endTime!)
		}
		
		
		let userJson = json["owner"] as? [String: Any]
		if userJson != nil {
			self.owner = User(json: userJson!)
		}
		
		let rankings = json["ranking"] as? [[String: Any]]
		if rankings != nil {
			for ranking in rankings! {
				self.rankings.append(Ranking(json: ranking)!)
			}
		}
		
		let users = json["users"] as? [[String: Any]]
		if users != nil {
			for user in users! {
				self.users.append(User(json: user)!)
			}
		}
		
	}
}

struct Ranking: JsonInit {
	let pub: Pub
	let time: Date
	
	init?(json: [String: Any]) {
		guard let time = json["time"] as? String,
			let pub = json["pub"] as? [String: Any]
			else {
				return nil
		}
		
		self.time = Api.sharedInstance.date(from: time)
		self.pub = Pub(json: pub)!
	}
}
