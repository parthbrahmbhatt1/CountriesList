//
//  Country.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let code: String
    let capital: String
}
