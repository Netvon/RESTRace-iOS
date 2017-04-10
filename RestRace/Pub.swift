//
//  Pub.swift
//  RestRace
//
//   09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import MapKit

struct Pub: ModelBase {
	
	let isError = false
	
	let placeId: String?
	var id: String
	
	let name: String
	let lon: Double?
	let lat: Double?
	
	
	
	init?(json: [String : Any]) {
		guard let id = json["_id"] as? String,
			let name = json["name"] as? String
 			else {
				return nil
		}
		
		self.id = id
		self.placeId = json["placeId"] as? String
		self.name = name
		self.lon = json["lon"] as! Double?
		self.lat = json["lat"] as! Double?
	}
}

class PubAnnotation: NSObject, MKAnnotation {
	let pub: Pub
	
	var subtitle: String? = ""
	var title: String? {
		get {
			return pub.name
		}
	}
	var coordinate: CLLocationCoordinate2D {
		get {
			return CLLocationCoordinate2D(latitude: pub.lat! as CLLocationDegrees, longitude: pub.lon! as CLLocationDegrees)
		}
	}
	
	init(pub: Pub) {
		self.pub = pub
		
		super.init()
	}
}
