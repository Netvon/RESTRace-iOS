//
//  RequestHelper.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


class RequestHelper {
	static func createRequest(method: String, url: String) -> URLRequest? {
		return createRequest(method: method, url: url, headers: nil, json: nil)
	}
	
	static func createRequest(method: String, url: String, headers: [String:String]) -> URLRequest? {
		return createRequest(method: method, url: url, headers: headers, json: nil)
	}
	
	static func createRequest(method: String, url: String, json: Any) -> URLRequest? {
		return createRequest(method: method, url: url, headers: nil, json: json)
	}
	
	static func createRequest(method: String, url: String, headers: [String:String]?, json: Any?) -> URLRequest? {
		
		do {
			let base = Config.ApiBaseUrl
			var request = URLRequest(url: URL(string: url, relativeTo: base)!)
			request.httpMethod = method
			
			
			if json != nil {
				let jsonData = try JSONSerialization.data(withJSONObject: json!, options: .prettyPrinted)
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
	
	static func doRequest<T: ApiResponse>(with request: URLRequest?, completion: @escaping (T?, ErrorResponse?) -> Void) {
		
		let task = URLSession.shared.dataTask(with: request!) {data, response, error in
			
			guard let data = data, error == nil else {
				print("Something went wrong")
				return
			}
			
			guard let response = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
				return
			}
			
			if let err = ErrorResponse(json: response!) {
				completion(nil, err)
				return
			}
			
			if let out = T(json: response!) {
				completion(out, nil)
				return
			}
		}
		
		task.resume()
	}
}

extension URLRequest {
	func doApiRequest<T: ApiResponse>(completion: @escaping (T?, ErrorResponse?) -> Void) {
		RequestHelper.doRequest(with: self, completion: completion)
	}
}
