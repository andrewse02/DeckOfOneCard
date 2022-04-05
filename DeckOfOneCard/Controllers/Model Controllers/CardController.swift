//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Andrew Elliott on 4/5/22.
//

import Foundation
import UIKit

class CardController {
    
    private static let baseURL = "https://deckofcardsapi.com/api/deck/new/draw/?count=1"
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        guard let url = URL(string: self.baseURL) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            } else {
                guard let data = data else {
                    return completion(.failure(.noData))
                }
                
                do {
                    let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                    
                    guard let card = topLevelObject.cards.first else {
                        return completion(.failure(.noData))
                    }
                    
                    completion(.success(card))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.thrownError(error)))
                }
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        guard let url = URL(string: card.image) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            } else {
                guard let data = data else { return completion(.failure(.noData)) }
                guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
                
                completion(.success(image))
            }
        }.resume()
    }
}
