//
//  RequestHelper.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

class RequestHelper {
	static func createRequest(method: String, url: String, headers: [String:String]?, json: Any?) -> URLRequest? {
		do {
			var request = URLRequest(url: URL(string: url, relativeTo: Config.ApiBaseUrl)!)
			request.httpMethod = method
			
			
			if json != nil {
				let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
				request.httpBody = jsonData
				request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
				
			}
			
			if headers != nil {
				for header in headers! {
					request.setValue(header.value, forHTTPHeaderField: header.key)
				}
			}
			
			return request
		} catch {
			return nil
		}
	}
}
