//
//  EditRaceController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 10/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import UIKit

class EditRaceController: UIViewController, UITextViewDelegate {
	
    @IBOutlet weak var bbSave: UIBarButtonItem!
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var tvDescription: UITextView!
	var race: Race?
	
	@IBAction func btnSaveClicked(_ sender: Any) {
		Api.sharedInstance.putRaces(id: (race?.id)!, data: [ "description": tvDescription.text ]) { race, error in
			
		}
	}
    
    func textViewDidChange(_ textView: UITextView) {
            bbSave.isEnabled = textView.text != nil || textView.text != ""
    }
	
	override func viewDidLoad() {
		
		tvDescription.text = race?.description
		niTitle.prompt = race?.name
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
		self.view.addGestureRecognizer(tap)
	}
	
	func dissmissKeyboard() {
		self.view.endEditing(true)
	}
}
