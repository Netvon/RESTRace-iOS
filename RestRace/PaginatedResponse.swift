//
//  PaginatedResponse.swift
//  RestRace
//
//   07/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class PaginatedResponse<T: JsonInit>: ApiResponse {
	let isError: Bool = false
	
	let limit: Int
	let skip: Int
	
	let next: String?
	let prev: String?
	
	let currentPage: Int
	let totalItems: Int
	let totalPages: Int
	
	var items: Array<T> = []
	
	var nextRequest: URLRequest? {
		get {
			if next != nil {
				return RequestHelper.createRequest(method: "GET", url: next!, headers: Api.sharedInstance.tokenHeader!)
			}
			
			return nil
		}
	}
	
	var prevRequest: URLRequest? {
		get {
			if next != nil {
				return RequestHelper.createRequest(method: "GET", url: prev!, headers: Api.sharedInstance.tokenHeader!)
			}
			
			return nil
		}
	}
	
	
	required init?(json: [String: Any]) {
		guard	let limit = json["limit"] as? Int,
				let skip = json["skip"] as? Int,
				let currentPage = json["currentPage"] as? Int,
				let totalPages = json["totalPages"] as? Int,
				let totalItems = json["totalItems"] as? Int
		
			else {
				return nil
		}
		
		
		self.limit = limit
		self.skip = skip
		self.currentPage = currentPage
		self.totalItems = totalItems
		self.totalPages = totalPages
		
		self.next = json["next"] as? String
		self.prev = json["prev"] as? String
		
		for item in json["items"] as! [[String: Any]] {
			items.append(T(json: item)!)
		}
	}
}
