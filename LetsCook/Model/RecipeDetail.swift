//
//  RecipeDetail.swift
//  LetsCook
//
//  Created by Catalina Severino Giraldo on 26/09/20.
//  Copyright © 2020 catalina. All rights reserved.
//

import Foundation

struct RecipeDetail: Decodable {
    let id: Int
    let title: String
    let rating: Int
    let imageURL: String
    let instructions: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating
        case imageURL = "image"
        case instructions
    }
}
