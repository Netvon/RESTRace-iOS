//
//  RaceController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

import UIKit


class RaceController: UIViewController {
	var race: Race?
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var tvDescription: UITextView!
	
	override func viewDidLoad() {
		if race != nil {
			niTitle.title = race?.name
			tvDescription.text = race?.description
		}
	}
}
