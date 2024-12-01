//
//  ViewState.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case success
    case empty
    case error(String)
}
