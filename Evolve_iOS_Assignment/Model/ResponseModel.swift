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

struct Items: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let promoText: String
    let thumbImage: String
    let problems: [String]
    let sessions: String
    let mins: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, title, problems, mins, sessions
        
        case promoText = "promo_text"
        case thumbImage = "thumb_image"
    }
    
}

struct Item: Identifiable, Codable {
    
    let id: String
    let title: String
    let juLabel: String
    let promoText: String
    let description: String
    
    let thumbImage: String
    let coverImage: String
    let juLink: String?
    let problems: [String]
    let techniques: [String]
    let details: String
    let sessions: String
    let mins: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case juLabel = "ju_label"
        case promoText = "promo_text"
        case description
        case thumbImage = "thumb_image"
        case coverImage = "cover_image"
        case juLink = "ju_link"
        case problems
        case techniques
        case details
        case sessions
        case mins
    }
}


