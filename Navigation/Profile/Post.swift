//
//  File.swift
//  Navigation
//
//  Created by Ислам on 03.10.2024.
//

import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

let posts: [Post] = [
    Post(author: "JohnDoe", description: "Exploring the mountains!", image: "mountain", likes: 120, views: 450),
    Post(author: "JaneSmith", description: "A wonderful sunset", image: "sunset", likes: 95, views: 400),
    Post(author: "CoolGuy", description: "Loving this view from the city", image: "city", likes: 230, views: 500),
    Post(author: "Traveler", description: "Beach vibes only", image: "beach", likes: 180, views: 480)
]
