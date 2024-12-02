//
//  CustomError.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

enum APIError: Error, LocalizedError, Equatable {
    
    case invaildURL(String)
    case serverError(String)
    case invalidData(String)
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .invaildURL(let message):
            return "Invalid URL: \(message)"
        case .serverError(let message):
            return "Server Error: \(message)"
        case .invalidData(let message):
            return "Invalid Data: \(message)"
        case .unknown(let messasge):
            return "Unknown Error: \(messasge)"
        }
    }
}
