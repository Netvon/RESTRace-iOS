//
//  Api.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class Api {
	
	static let sharedInstance = Api()
	
	var token: String? {
		get {
			return UserDefaults.standard.string(forKey: "API_TOKEN")
		}
		
		set(newToken) {
			UserDefaults.standard.set(newToken, forKey: "API_TOKEN")
		}
	}
	
	var user: User? = nil
	
	func getNewToken(username: String, password: String, completion: @escaping (ApiResponse) -> Void) {
		
		let json = [ "username": username, "password": password ]
			
		let request = RequestHelper.createRequest(method: "POST", url: "/auth/token", json: json)
		
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
				return
			}
				
			if let token = TokenResponse(json: response!) {
				self.token = token.token
				completion(token)
				return
			}
		}
			
		task.resume()
	}
	
	func getUsers(limit: Int = 2, sort: String? = nil, filter: String? = nil, completion: @escaping (ApiResponse) -> Void) {
		
		let request = RequestHelper.createRequest(method: "GET", url: "/api/users?limit=\(limit)", headers: ["Authorization": "JWT \(self.token!)"] )
		
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
				return
			}
			
			if let token = PaginatedResponse<User>(json: response!) {
				completion(token)
				return
			}
		}
		
		task.resume()
	}
	
	func getCurrentUser(completion: @escaping (ApiResponse) -> Void) {
		
		let request = RequestHelper.createRequest(method: "GET", url: "/auth/me", headers: ["Authorization": "JWT \(self.token!)"] )
		
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
				return
			}
			
			if let user = User(json: response!) {
				completion(user)
				return
			}
		}
		
		task.resume()
	}
}
