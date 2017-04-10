//
//  EditRaceController.swift
//  RestRace
//
//   10/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import UIKit

class EditRaceController: BaseController, UITextViewDelegate {
	
    @IBOutlet weak var uiLoading: UIActivityIndicatorView!
    @IBOutlet weak var bbSave: UIBarButtonItem!
	@IBOutlet weak var niTitle: UINavigationItem!
	@IBOutlet weak var tvDescription: UITextView!
	
	var race: Race?
	
	@IBAction func btnSaveClicked(_ sender: Any) {
        self.uiLoading.startAnimating()
        self.bbSave.isEnabled = false
        
		Api.sharedInstance.putRaces(id: (race?.id)!, data: [ "description": tvDescription.text ]) { race, error in
			DispatchQueue.main.async {
				
				if error != nil {
					self.showError(error: error!)
					self.uiLoading.stopAnimating()
					self.bbSave.isEnabled = true
					return
				}
				
				self.race?.description = self.tvDescription.text
				self.uiLoading.stopAnimating()
				
				self.navigationController?.popViewController(animated: true)
                
			}
		}
	}
	
    func textViewDidChange(_ textView: UITextView) {
		bbSave.isEnabled = textView.text != nil || textView.text != ""
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tvDescription.text = race?.description
		niTitle.prompt = race?.name
	}
}
