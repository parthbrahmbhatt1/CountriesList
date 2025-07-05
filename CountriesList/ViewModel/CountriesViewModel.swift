//
//  CountriesViewModel.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation
import UIKit

@MainActor
class CountriesViewModel {
    private(set) var countries: [Country] = []
    private(set) var filteredCountries: [Country] = []
    var onDataChanged: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var isFiltering: Bool = false
    
    var count: Int {
        return isFiltering ? filteredCountries.count : countries.count
    }
    
    func country(at index: Int) -> Country {
        return isFiltering ? filteredCountries[index] : countries[index]
    }
    
    func fetchCountries() async {
        let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        guard let url = URL(string: urlString) else {
            onError?("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Country].self, from: data)
            self.countries = decoded
            self.onDataChanged?()
            
        } catch {
            self.onError?("Failed to fetch countries: \(error.localizedDescription)")
        }
    }
    
    func filter(with searchText: String) {
        let lowercased = searchText.lowercased()
        if lowercased.isEmpty {
            isFiltering = false
            filteredCountries = []
        } else {
            isFiltering = true
            filteredCountries = countries.filter {
                $0.name.lowercased().contains(lowercased) ||
                $0.capital.lowercased().contains(lowercased)
            }
        }
        onDataChanged?()
    }
}
