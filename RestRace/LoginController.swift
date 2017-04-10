//
//  ViewController.swift
//  RestRace
//
//   05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import UIKit

class LoginController: BaseController {
	
	@IBOutlet weak var tfUsername: UITextField!
	@IBOutlet weak var tfPassword: UITextField!
	@IBOutlet weak var aiLoading: UIActivityIndicatorView!
	@IBOutlet weak var btnLogin: UIButton!
	@IBOutlet weak var btnRegister: UIButton!
	
	@IBAction func btnRegisterClicked(_ sender: Any) {
		setLoading(state: true)
		
		Api.sharedInstance.registerUser(username: tfUsername.text!, password: tfPassword.text!) { user, error in
			
			if error != nil {
				print("Error: \(error?.message)")
				
				DispatchQueue.main.async {
					self.setLoading(state: false)
					self.showError(name: "Register Failed", reason: "Username Taken")
				}
				
				return
			}
			
			print("NewUser: \(user?.username)")
			Api.sharedInstance.username = self.tfUsername.text!
			
			DispatchQueue.main.async {
				self.setLoading(state: false)
				self.tfPassword.text = nil
				
				self.showInfo(name: "Register Complete", message: "A new account has been created. Enter your new information to login")
			}
		}
	}
	

	@IBAction func btnLoginClicked(_ sender: Any) {
		
		setLoading(state: true)
		
		Api.sharedInstance.getNewToken(username: tfUsername.text!, password: tfPassword.text!) { response, error in
			
			if error != nil {
				print("Error: \(error?.message)")
				
				DispatchQueue.main.async {
					self.setLoading(state: false)
					self.showError(error: error!)
				}
				
				return
			}
			
			print("Token \(response?.token)")
			Api.sharedInstance.token = response?.token
			Api.sharedInstance.username = self.tfUsername.text!
	
			DispatchQueue.main.async {
				self.setLoading(state: false)
				self.performSegue(withIdentifier: "showMain", sender: self)
			}
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if Api.sharedInstance.token != nil {
			self.performSegue(withIdentifier: "showMain", sender: self)
		}
		
		if let username = Api.sharedInstance.username {
			tfUsername.text = username
		}
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
		btnRegister.isEnabled = !state
	}}

