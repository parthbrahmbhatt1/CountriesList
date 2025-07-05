//
//  Constants.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import Foundation

enum Constants {
    enum API {
        static let url = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        static let invalidURL = "Invalid URL"
        static let failedToFetchCountries = "Failed to fetch countries:"
    }
    
    enum CountryListView {
        static let countries = "Countries"
        static let searchCountriesOrCapitals = "Search countries or capitals"
        static let error = "Error"
        static let ok = "OK"
        static let noDataCell = "NoDataCell"
        static let noDataFound = "No data found"
        static let countryCell = "CountryCell"
        static let emptyString = ""
    }
}
