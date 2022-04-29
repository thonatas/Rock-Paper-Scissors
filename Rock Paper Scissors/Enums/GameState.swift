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
            return UIColor(hex: "81F5FF")
        case .victory:
            return UIColor(hex: "A0FFE6")
        case .defeat:
            return UIColor(hex: "FFD5E5")
        case .draw:
            return UIColor(hex: "FFFFDD")
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .start:
            return UIColor(hex: "4B7BE5")
        case .victory:
            return UIColor(hex: "069A8E")
        case .defeat:
            return UIColor(hex: "FF6FB5")
        case .draw:
            return UIColor(hex: "FFD36E")
        }
    }
}
