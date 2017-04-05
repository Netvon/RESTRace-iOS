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
	
	@IBAction func btnLoginClicked(_ sender: Any) {
		
		Api.getToken(username: tfUsername.text!, password: tfPassword.text!) { response in
			switch(response) {
			case let error as ErrorResponse:
				print("Error: \(error.message)")
				
			case let token as TokenResponse:
				print("Token \(token.token)")
				
			default:
				print("Unkown error")
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


}

