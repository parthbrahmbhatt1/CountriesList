//
//  CountriesViewModelTests.swift
//  CountriesListTests
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import XCTest
@testable import CountriesList

final class CountriesViewModelTests: XCTestCase {
    
    @MainActor
    func testFetchCountriesSuccess() async {
        let mockService = MockCountryService()
        let country = Country(name: "Testland", region: "EU", code: "TL", capital: "Testville")
        mockService.countriesToReturn = [country]
        let viewModel = CountriesViewModel(service: mockService)
        let expectation = expectation(description: "Data changed called")
        
        viewModel.onDataChanged = {
            expectation.fulfill()
        }

        await viewModel.fetchCountries()
        
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.countries.count, 1)
        XCTAssertEqual(viewModel.countries.first?.name, "Testland")
    }


    @MainActor
    func testFetchCountriesFailure() async {
        let mockService = MockCountryService()
        mockService.errorToThrow = URLError(.badServerResponse)
        let viewModel = CountriesViewModel(service: mockService)
        let expectation = expectation(description: "Error called")
        var capturedError: String?
        
        viewModel.onError = { error in
            capturedError = error
            expectation.fulfill()
        }

        await viewModel.fetchCountries()
        
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertNotNil(capturedError)
    }
}
