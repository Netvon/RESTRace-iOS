//
//  ViewController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var tfUsername: UITextField!
	@IBOutlet weak var tfPassword: UITextField!
	@IBOutlet weak var aiLoading: UIActivityIndicatorView!
	@IBOutlet weak var btnLogin: UIButton!
	@IBOutlet weak var btnRegister: UIButton!
	
	@IBAction func btnLoginClicked(_ sender: Any) {
		
		setLoading(state: true)
		
		Api.getToken(username: tfUsername.text!, password: tfPassword.text!) { response in
			switch(response) {
			case let error as ErrorResponse:
				print("Error: \(error.message)")
				
				DispatchQueue.main.async {
					self.showError(error: error)
				}
				
			case let token as TokenResponse:
				print("Token \(token.token)")
				
				
			default:
				print("Unkown error")
			}
			
			DispatchQueue.main.async {
				self.setLoading(state: false)
			}
		}
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func showError(error: ErrorResponse) {
		let alert = UIAlertController(title: "Error", message: "\(error.message): \(error.reason)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func setLoading(state: Bool) {
		if state {
			aiLoading.startAnimating()
		} else {
			aiLoading.stopAnimating()
		}
		
		tfUsername.isEnabled = !state
		tfPassword.isEnabled = !state
		btnLogin.isEnabled = !state
	}}

