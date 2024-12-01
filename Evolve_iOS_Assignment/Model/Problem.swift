//
//  Problem.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

struct Problem: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}

