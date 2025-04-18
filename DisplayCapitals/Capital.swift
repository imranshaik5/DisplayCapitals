//
//  Capital.swift
//  Capitals
//
//  Created by Imran shaik on 18/04/25.
//


import Foundation

/// Model to hold the data raceived from Server as json
struct Capital: Codable {
    let name: String
    let region: String
    let code: String
    let capital: String
}
