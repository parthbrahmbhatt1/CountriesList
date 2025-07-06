//
//  CountryListViewController.swift
//  CountriesList
//
//  Created by Parth Brahmbhatt on 7/5/25.
//

import UIKit

class CountryListViewController: UITableViewController {
    
    let viewModel = CountriesViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.CountryListView.countries
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.CountryListView.searchCountriesOrCapitals
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        viewModel.onDataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] message in
            self?.showError(message)
        }
        
        Task {
            await viewModel.fetchCountries()
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: Constants.CountryListView.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.CountryListView.ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CountryListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isFiltering {
            return viewModel.filteredCountries.isEmpty ? 1 : viewModel.filteredCountries.count
        } else {
            return viewModel.countries.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isFiltering && viewModel.filteredCountries.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.CountryListView.noDataCell)
            cell.textLabel?.text = Constants.CountryListView.noDataFound
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CountryListView.countryCell, for: indexPath) as! CountryCell
        let country: Country
        if viewModel.isFiltering {
            country = viewModel.filteredCountries[indexPath.row]
        } else {
            country = viewModel.countries[indexPath.row]
        }
        cell.configure(with: country)
        return cell
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? Constants.CountryListView.emptyString
        viewModel.filter(with: searchText)
    }
}
