//
//  Config.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


class Config {
	static var ApiBaseUrl: URL {
		get{
			return URL(string: "https://damp-sierra-83365.herokuapp.com")!
		}
	}
}
