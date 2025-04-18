//
//  CpaitalsViewModel.swift
//  Capitals
//
//  Created by Imran shaik on 18/04/25.
//


import Foundation


/// View model to handle the data associated with view controller
class CapitalsViewModel {
    private let capitalService: CapitalServiceProtocol
    
    private var capitals: [Capital] = []
    var capitalsToDisplay: [Capital] = []
    var onCapitalsUpdated: (() -> Void)?
    var onError: ((APIError) -> Void)?
    
    
    /// Initializer
    /// - Parameter capitalService: Service to handle the API calls
    init(capitalService: CapitalServiceProtocol = CapitalService()) {
        self.capitalService = capitalService
    }
    
    
    /// Fetch the capitals from the api service
    func fetchCapitals() {
        capitalService.fetchCapitals { [weak self] (result: Result<[Capital], APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let capitals):
                    self?.capitals = capitals
                    self?.capitalsToDisplay = capitals
                    self?.onCapitalsUpdated?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
    
    
    /// Filter the capitals based on the search text
    /// - Parameter searchText: Text to filter the object based on name & capital
    func filterCapitals(by searchText: String) {
        guard !searchText.isEmpty else {
            capitalsToDisplay = capitals
            onCapitalsUpdated?()
            return
        }
        
        let lowercasedSearchText = searchText.lowercased()
        capitalsToDisplay = capitals.filter {
            $0.name.lowercased().contains(lowercasedSearchText) || $0.capital.lowercased().contains(lowercasedSearchText)
        }
        onCapitalsUpdated?()
    }
}
