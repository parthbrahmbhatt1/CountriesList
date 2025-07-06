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
    private let service: CountryServiceProtocol
    
    init(service: CountryServiceProtocol = CountryService()) {
        self.service = service
    }
    
    var isFiltering: Bool = false
    
    var count: Int {
        return isFiltering ? filteredCountries.count : countries.count
    }
    
    func country(at index: Int) -> Country {
        return isFiltering ? filteredCountries[index] : countries[index]
    }
    
    func fetchCountries() async {
        do {
            let decoded = try await service.fetchCountries()
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
                ($0.name.isEmpty ? Constants.CountryListView.na.lowercased() : $0.name.lowercased()).contains(lowercased) ||
                ($0.capital.isEmpty ? Constants.CountryListView.na.lowercased() : $0.capital.lowercased()).contains(lowercased)
            }
        }
        onDataChanged?()
    }

}
