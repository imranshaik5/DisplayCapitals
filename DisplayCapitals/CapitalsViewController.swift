//
//  CapitalViewController.swift
//  Capitals
//
//  Created by Imran shaik on 18/04/25.
//


import UIKit

/// View controller to display the capitals
class CapitalsViewController: UIViewController {
    let viewModel = CapitalsViewModel() //View Model

    @IBOutlet weak var capitalsList: UITableView!
    
    
    
    /// Called when the view is loading. Initialize the objects and fetch capitals
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetchCapitals()
    }

    
    /// Bind the view model with the view controller to handle the errors
    private func bindViewModel() {
        viewModel.onCapitalsUpdated = { [weak self] in
            self?.capitalsList.reloadData()
        }

        viewModel.onError = { error in
            Helper.showAlert(title: "Error", message: error.localizedDescription, from: self)
        }
    }
}

/// Extension for view contorller to handle the table view data source
extension CapitalsViewController: UITableViewDataSource {
    
    /// Table View delegate to return the number of rows in a section
    /// - Parameters:
    ///   - tableView: Table view object
    ///   - section: Section number in which the rows count has to be presented
    /// - Returns: Number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.capitalsToDisplay.count
    }

    
    /// Render the cell
    /// - Parameters:
    ///   - tableView: Table view object
    ///   - indexPath: Indexpath of the cell that needs rendering
    /// - Returns: Cell with rendered conent
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let capital = viewModel.capitalsToDisplay[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CapitalCellID", for: indexPath) as? CapitalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.name.text = capital.name + ", " + capital.region
        cell.code.text = capital.code
        cell.capital.text = capital.capital
        
        return cell
    }
}

/// Extension for view contorller to handle the search bar text changes
extension CapitalsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCapitals(by: searchBar.text ?? "")
    }
}
