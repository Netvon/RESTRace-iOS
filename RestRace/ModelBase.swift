//
//  ModelBase.swift
//  RestRace
//
//   09/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation


protocol ModelBase: ApiResponse {
	var id: String { get }
}
