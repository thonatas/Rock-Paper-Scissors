//
//  Sinais.swift
//  jogo-pedra-papel-e-tesoura
//
//  Created by Thonatas Borges on 04/01/21.
//

import UIKit
import GameplayKit

enum Sign: String {
    case rock = "👊"
    case paper = "✋"
    case scissors = "✌️"
    case none = ""
}

func randomSign() -> String {
    let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)
    let sign = randomChoice.nextInt()
    
    if sign == 0 {
        return "👊"
    } else if sign == 1 {
        return "✋"
    } else {
        return "✌️"
    }
}
