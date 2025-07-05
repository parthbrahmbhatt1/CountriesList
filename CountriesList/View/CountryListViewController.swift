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
        title = "Countries"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search countries or capitals"
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
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isFiltering {
            return viewModel.filteredCountries.isEmpty ? 1 : viewModel.filteredCountries.count
        } else {
            return viewModel.countries.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isFiltering && viewModel.filteredCountries.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "NoDataCell")
            cell.textLabel?.text = "No data found"
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country: Country
        if viewModel.isFiltering {
            country = viewModel.filteredCountries[indexPath.row]
        } else {
            country = viewModel.countries[indexPath.row]
        }
        cell.nameRegionLabel.text = "\(country.name), \(country.region)"
        cell.codeLabel.text = country.code
        cell.capitalLabel.text = country.capital
        return cell
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.filter(with: searchText)
    }
}
