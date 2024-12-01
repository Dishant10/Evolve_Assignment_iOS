//
//  Model.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation

struct Response: Codable {
    let first: Int
    let prev: Int?
    let next: Int?
    let last: Int
    let pages: Int
    let items: Int
    let data : [Item]
}

struct Item: Identifiable, Codable,Equatable {
    let id: Int
    let title: String
    let promoText: String
    let description: String
    let numDays: Int
    let thumbImage: String
    let coverImage: String
    let problems: [String]
    let sessions: String
    let mins: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, title, problems, description, mins, sessions
        
        case promoText = "promo_text"
        case numDays = "num_days"
        case thumbImage = "thumb_image"
        case coverImage = "cover_image"
    }
    
}


