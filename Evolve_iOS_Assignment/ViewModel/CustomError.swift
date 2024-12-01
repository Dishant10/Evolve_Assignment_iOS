//
//  CustomError.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

enum CustomError: Error, LocalizedError {
    
    case invaildURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invaildURL:
            return "Invalid URL"
        case .serverError:
            return "There was an error was the server. Please try again"
        case .invalidData:
            return "Response data is invalid or corrupted"
        case .unknown(let error):
            return "Unknown Error: \(error.localizedDescription)"
        }
    }
}
