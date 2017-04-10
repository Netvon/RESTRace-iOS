//
//  ApiResponse.swift
//  RestRace
//
//   05/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


protocol ApiResponse: JsonInit {
	var isError: Bool { get }
}
