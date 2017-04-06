//
//  ErrorResponse.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


struct ErrorResponse: ApiResponse {
	let message: String
	let reason: String
	let name: String
	let isError: Bool = true
	
	init?(json: [String: Any]) {
		guard let error = json["error"] as? [String: Any]
			else {
				return nil
		}
		
		self.reason = error["reason"] as! String
		self.message = error["message"] as! String
		self.name = error["name"] as! String
	}
	
	func show() {
		print("Name: \(self.name), \(self.message)")
	}
}
