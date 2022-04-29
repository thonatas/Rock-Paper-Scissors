//
//  Sinais.swift
//  jogo-pedra-papel-e-tesoura
//
//  Created by Thonatas Borges on 04/01/21.
//

import UIKit
import GameplayKit

enum Sign: String, CaseIterable {
    case rock = "👊"
    case paper = "✋"
    case scissors = "✌️"
    
    var toggle: Sign {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .rock:
            return UIImage(systemName: "r.square")
        case .paper:
            return UIImage(systemName: "p.square")
        case .scissors:
            return UIImage(systemName: "s.square")
        }
    }
    
    var tag: Int {
        switch self {
        case .rock:
            return 0
        case .paper:
            return 1
        case .scissors:
            return 2
        }
    }
    
    func statusOfGame() -> (gameState: GameState, robotChoice: Sign) {
        let robotChoice = randomSign()
        let isUserWinner = self.toggle == robotChoice
        var gameState: GameState = isUserWinner ? .victory : .defeat
        
        if self == robotChoice {
            gameState = .draw
        }
        
        return (gameState: gameState, robotChoice: robotChoice)
    }
}

func randomSign() -> Sign {
    let signs = Sign.allCases
    let index = GKRandomDistribution(lowestValue: 0, highestValue: signs.count - 1).nextInt()
    return signs[index]
}
