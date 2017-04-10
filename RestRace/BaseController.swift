//
//  BaseController.swift
//  RestRace
//
//   10/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation
import UIKit

class BaseController: UIViewController {
	
	override open func viewDidLoad() {
		super.viewDidLoad()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
		self.view.addGestureRecognizer(tap)
	}
	
	public func dissmissKeyboard() {
		self.view.endEditing(true)
	}
	
	public func showError(error: ErrorResponse) {
		showError(name: error.message!, reason: error.reason!)
	}
	
	public func showError(name: String, reason: String) {
		let alert = UIAlertController(title: "Error", message: "\(name): \(reason)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	public func showInfo(name: String, message: String) {
		let alert = UIAlertController(title: "Info", message: "\(name): \(message)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
	}
}
