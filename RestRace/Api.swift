//
//  Api.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class Api {
	
	public static let sharedInstance = Api()
	
	public var token: String? {
		get {
			return UserDefaults.standard.string(forKey: "API_TOKEN")
		}
		
		set(newToken) {
			UserDefaults.standard.set(newToken, forKey: "API_TOKEN")
			user = nil
		}
	}
	
	public var user: User? {
		didSet {
			if user != nil {
				username = user?.username
			}
		}
	}
	
	public var username: String? {
		get {
			return UserDefaults.standard.string(forKey: "API_USERNAME")
		}
		
		set(newUsername) {
			UserDefaults.standard.set(newUsername, forKey: "API_USERNAME")
		}
	}
	
	public var tokenHeader: [String: String]? {
		get {
			if token != nil {
				return ["Authorization": "JWT \(self.token!)"]
			}
			
			return nil
		}
	}
	
	public func registerUser(username: String, password: String, completion: @escaping (User?, ErrorResponse?) -> Void) {
		
		RequestHelper.createRequest(method: "POST", url: "/api/users", json: [ "username": username, "password": password ] )?
			.doApiRequest(completion: completion)
	}
	
	public func getNewToken(username: String, password: String, completion: @escaping (TokenResponse?, ErrorResponse?) -> Void) {
		
		RequestHelper.createRequest(method: "POST", url: "/auth/token", json: [ "username": username, "password": password ] )?
			.doApiRequest(completion: completion)
	}
	
	public func getUsers(limit: Int = 20, sort: String? = nil, filter: String? = nil, completion: @escaping (PaginatedResponse<User>?, ErrorResponse?) -> Void) {
		
		RequestHelper.createRequest(method: "GET", url: "/api/users?limit=\(limit)", headers: self.tokenHeader! )?
			.doApiRequest(completion: completion)
	}
	
	public func getRaces(limit: Int = 20, sort: String? = nil, filter: String? = nil, completion: @escaping (PaginatedResponse<Race>?, ErrorResponse?) -> Void) {
		
		RequestHelper.createRequest(method: "GET", url: "/api/races?limit=\(limit)", headers: self.tokenHeader! )?
			.doApiRequest(completion: completion)
	}
	
	public func getCurrentUser(completion: @escaping (User?, ErrorResponse?) -> Void) {
		
		RequestHelper.createRequest(method: "GET", url: "/auth/me", headers: self.tokenHeader! )?
				.doApiRequest(completion: completion)
	}
	
	public func date(from dateString: String) -> Date {
		let formatter = DateFormatter()
		
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		if let parsedDate = formatter.date(from: dateString) {
			return parsedDate
		}
		
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
		if let parsedDate = formatter.date(from: dateString) {
			return parsedDate
		}
		
		return Date.distantPast
	}
}

