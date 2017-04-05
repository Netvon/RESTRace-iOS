//
//  Api.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class Api {
	
	static func getToken(username: String, password: String, completion: @escaping (ApiResponse) -> Void) {
		
		let json = ["username": username, "password": password]
			
		let request = RequestHelper.createRequest(method: "POST", url: "/auth/token", headers: nil, json: json)
		
		
		let task = URLSession.shared.dataTask(with: request!) {data, response, error in
			guard let data = data, error == nil else {
				print("Something went wrong")
				return
			}
				
			guard let response = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
				return
			}
				
			if let err = ErrorResponse(json: response!) {
				completion(err)
			}
				
			if let token = TokenResponse(json: response!) {
				completion(token)
			}
				
		}
			
		task.resume()
	}
}
