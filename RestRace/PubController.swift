//
//  PubController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PubController: UIViewController {
	
	var pub: Pub?
	var annotation: PubAnnotation?
	
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var btnOpenMaps: UIBarButtonItem!
	
	override func viewDidLoad() {
		btnOpenMaps.action = #selector(openInMaps(sender:))
		niTitle.title = pub?.name
		
		annotation = PubAnnotation(pub: pub!)
		mapView.addAnnotation(annotation!)
		
		let radius: CLLocationDistance = 1000
		let coordinateRegion = MKCoordinateRegionMakeWithDistance((annotation?.coordinate)!, radius * 2.0, radius * 2.0)
		
		mapView.setRegion(coordinateRegion, animated: true)
	}
	
	func openInMaps(sender: UIBarButtonItem) {
		let placemark = MKPlacemark(coordinate: (annotation?.coordinate)!)
		
		let item = MKMapItem(placemark: placemark)
		item.name = pub?.name
		item.openInMaps(launchOptions: nil)
	}
}
