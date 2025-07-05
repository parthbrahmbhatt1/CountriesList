//
//  CountryService.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation

protocol CountryServiceProtocol {
    func fetchCountries() async throws -> [Country]
}

class CountryService: CountryServiceProtocol {
    func fetchCountries() async throws -> [Country] {
        let urlString = Constants.API.url
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Country].self, from: data)
    }
}
