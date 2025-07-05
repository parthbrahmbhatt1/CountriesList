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
        let urlString = Constants.API.url
        guard let url = URL(string: urlString) else {
            onError?(Constants.API.invalidURL)
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Country].self, from: data)
            self.countries = decoded
            self.onDataChanged?()
            
        } catch {
            self.onError?("\(Constants.API.failedToFetchCountries) \(error.localizedDescription)")
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
