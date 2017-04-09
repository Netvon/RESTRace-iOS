//
//  Races.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 08/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

struct Race: ModelBase {
	
	let isError = false
	
	enum RaceStatus: String {
		case notStarted = "notstarted"
		case started = "started"
		case ended = "ended"
	}
	
	let id: String
	let name: String
	let description: String?
	let status: RaceStatus
	let tags: [String]?
	
	init?(json: [String : Any]) {
		guard let id = json["_id"] as? String,
			let name = json["name"] as? String,
			let status = json["status"] as? String
			
			else {
				return nil
		}
		
		self.id = id
		self.name = name
		self.description = json["description"] as? String
		self.tags = json["tags"] as! [String]?
		self.status = RaceStatus.init(rawValue: status)!
	}
	
}
