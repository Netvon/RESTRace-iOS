//
//  TokenResponse.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


struct TokenResponse: ApiResponse {
	let message: String
	let token: String
	let isError: Bool = false
	let status: Int = 200
	
	init(token: String) {
		self.token = token
		self.message = ""
	}
	
	init?(json: [String: Any]) {
		guard let message = json["message"] as? String,
			let token = json["token"] as? String
		else {
			return nil
		}
		
		self.message = message
		self.token = token
	}
	
	func show() {
		print("Message: \(self.message), \(self.token)")
	}
}
