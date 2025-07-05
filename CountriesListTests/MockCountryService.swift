//
//  MockCountryService.swift
//  CountriesListTests
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation

class MockCountryService: CountryServiceProtocol {
    var countriesToReturn: [Country] = []
    var errorToThrow: Error?

    func fetchCountries() async throws -> [Country] {
        if let error = errorToThrow {
            throw error
        }
        return countriesToReturn
    }
}
