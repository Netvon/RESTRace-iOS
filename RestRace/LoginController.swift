//
//  ViewController.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
	@IBOutlet weak var tfUsername: UITextField!
	@IBOutlet weak var tfPassword: UITextField!
	@IBOutlet weak var aiLoading: UIActivityIndicatorView!
	@IBOutlet weak var btnLogin: UIButton!
	@IBOutlet weak var btnRegister: UIButton!
	
	@IBAction func btnLoginClicked(_ sender: Any) {
		
		setLoading(state: true)
		
		Api.sharedInstance.getNewToken(username: tfUsername.text!, password: tfPassword.text!) { response in
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
				self.performSegue(withIdentifier: "showTabController", sender: self)
			}
		}
		
		
//
		
//		Api.sharedInstance.getUsers { response in
//			switch(response) {
//			case let error as ErrorResponse:
//				print("Error: \(error.message)")
//				
//				DispatchQueue.main.async {
//					self.showError(error: error)
//				}
//				
//			case let paginated as PaginatedResponse<User>:
//				self.users = paginated
//				print("Get some \(paginated.totalItems)")
//				
//				
//			default:
//				print("Unkown error")
//			}
//			
//			DispatchQueue.main.async {
//				self.setLoading(state: false)
//				self.tvUsers.reloadData()
//			}
//		}
		
	}
	
//	var users: PaginatedResponse<User>?
//	
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if (users != nil) {
//			return users!.limit
//		} else {
//			return 0
//		}
//	}
//	
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//		
//		let user = users!.items[indexPath.row]
//		
//		if user.username != nil {
//			cell.textLabel?.text = user.username!
//		} else {
//			cell.textLabel?.text = user.id
//		}
//		
//		
//		
//		return cell
//	}
	
	override func viewDidAppear(_ animated: Bool) {
		if Api.sharedInstance.token != nil {
			self.performSegue(withIdentifier: "showTabController", sender: self)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
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
		btnRegister.isEnabled = !state
	}}

