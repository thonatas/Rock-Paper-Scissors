//
//  EstadoDoJogo.swift
//  jogo-pedra-papel-e-tesoura
//
//  Created by Thonatas Borges on 04/01/21.
//

import UIKit

enum GameState: Int {
    case start = 0
    case victory = 1
    case defeat = 2
    case draw = 3
    
    var title: String {
        switch self {
        case .start:
            return "Rock, Paper or Scissors?"
        case .victory:
            return "Won 😄!"
        case .defeat:
            return "You lost 🙁!"
        case .draw:
            return "Draw 😐!!!"
        }
    }

    var background: UIColor {
        switch self {
        case .start:
            return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case .victory:
            return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .defeat:
            return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case .draw:
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
    }
}
