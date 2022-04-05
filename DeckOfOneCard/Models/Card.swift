//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Andrew Elliott on 4/5/22.
//

import Foundation

struct Card: Decodable {
    var value: String
    var suit: String
    var image: String
}

struct TopLevelObject: Decodable {
    var cards: [Card]
}
