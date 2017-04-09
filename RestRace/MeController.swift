//
//  MeController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 07/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import UIKit


class MeController: UIViewController {
	
	@IBOutlet weak var lblUsername: UILabel!
	
	@IBAction func logoutClicked(_ sender: Any) {
		
		let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { action in
			Api.sharedInstance.token = nil
			Api.sharedInstance.user = nil
			
			self.performSegue(withIdentifier: "showLogin", sender: self)
		})
		
		self.present(alert, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let username = UserDefaults.standard.string(forKey: "API_USERNAME") {
			self.lblUsername.text = username
		}
		
		if Api.sharedInstance.user != nil {
			updateLabels()
			return
		}
		
		Api.sharedInstance.getCurrentUser { user, error in
			if error != nil {
				// handle errors
			}
			
			Api.sharedInstance.user = user
			
			DispatchQueue.main.async {
				self.updateLabels()
			}
		}
	}
	
	private func updateLabels() {
		self.lblUsername.text = Api.sharedInstance.user?.username!
	}
	
}
