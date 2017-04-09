//
//  User.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 07/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


struct User: ModelBase {
	
	let id: String
	let username: String?
	let roles: [String]?
	let firstname: String?
	let lastname: String?
	
	let isError: Bool = false
	
	init?(json: [String : Any]) {
		guard let id = json["_id"] as? String
			
			else {
				return nil
		}
		
		self.id = id
		self.roles = json["roles"] as? [String]
		self.firstname = json["firstname"] as? String
		self.lastname = json["lastname"] as? String
		
		let local = json["local"] as? [String: Any]
		self.username = local?["username"] as? String
	}
}
