//
//  PaginatedItem.swift
//  RestRace
//
//  Created by Tom van Nimwegen on 07/04/2017.
//  Copyright © 2017 Tom van Nimwegen & Luuk Spierings. All rights reserved.
//

import Foundation

protocol JsonInit
{
	init?(json: [String: Any])
}
