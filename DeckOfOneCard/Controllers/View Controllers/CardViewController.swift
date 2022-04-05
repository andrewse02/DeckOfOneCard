//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Andrew Elliott on 4/5/22.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func drawTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.nameLabel.text = "\(card.value) of \(card.suit)"
                    self?.imageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
