//
//  CountryCell.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation
import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var nameRegionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    func configure(with country: Country) {
        nameRegionLabel.text = "\(country.name.isEmpty ? Constants.CountryListView.na : country.name), \(country.region.isEmpty ? Constants.CountryListView.na : country.region)"
        codeLabel.text = country.code.isEmpty ? Constants.CountryListView.na : country.code
        capitalLabel.text = country.capital.isEmpty ? Constants.CountryListView.na : country.capital
    }
}
