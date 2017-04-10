//
//  RaceUpdatedResponse.swift
//  RestRace
//
//   10/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

struct RaceUpdatedResponse: ApiResponse {
	let item: Race
	let message: String
	
	let isError: Bool = false
	
	init?(json: [String: Any]) {
		guard let message = json["message"] as? String,
			let user = json["item"] as? [String: Any]
			else {
				return nil
		}
		
		self.message = message
		self.item = Race(json: user)!
	}
}
