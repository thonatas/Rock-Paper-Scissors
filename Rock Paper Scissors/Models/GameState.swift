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
}

func statusOfGame(_ userChoice: String, _ robotChoice: String) -> GameState {
    if userChoice == robotChoice {
        return .draw
    } else {
        switch userChoice {
        case "👊":
            if robotChoice == "✌️" {
                return .victory
            }
            break
        case "✋":
            if robotChoice == "👊" {
                return .victory
            }
            break
        case "✌️":
            if robotChoice == "✋" {
                return .victory
            }
            break
        default:
            return .start
        }
        return .defeat
    }
}
