//
//  ErrorResponse.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


struct ErrorResponse: ApiResponse, Error {
	
	let message: String?
	var status: Int? = nil
	let reason: String?
	var name: String? = nil
	
	let isError: Bool = true
	
	var values: [String?] = []
	
	init(message: String, reason: String) {
		self.message = message
		self.reason = reason
	}
	
	init?(json: [String: Any]) {
		guard let error = json["error"] as? [String: Any]
			else {
				return nil
		}
		
		self.reason = error["reason"] as? String
		self.status = error["status"] as? Int
		self.message = error["message"] as? String
		self.name = error["name"] as? String
		
		self.values = error.map { key, value in
			return value as? String
		}
	}
	
	func show() {
		print("Name: \(self.name), \(self.message)")
	}
}
