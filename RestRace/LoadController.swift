//
//  LoadController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 07/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import UIKit


class LoadController: UIViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		//Api.sharedInstance.token = nil
		
		
		if Api.sharedInstance.token != nil {
			self.performSegue(withIdentifier: "showMain", sender: self)
		} else {
			self.performSegue(withIdentifier: "showLogin", sender: self)
		}
	}
	
}
