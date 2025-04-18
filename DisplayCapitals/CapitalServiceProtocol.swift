//
//  CapitalServiceProtocol.swift
//  DisplayCapitals
//
//  Created by Imran shaik on 18/04/25.
//


import Foundation

protocol CapitalServiceProtocol {
    func fetchCapitals(completion: @escaping (Result<[Capital], APIError>) -> Void)
}

class CapitalService: CapitalServiceProtocol {
    func fetchCapitals(completion: @escaping (Result<[Capital], APIError>) -> Void) {
        let url = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        NetworkManager.shared.fetchData(from: url, completion: completion)
    }
}
