//
//  Sinais.swift
//  jogo-pedra-papel-e-tesoura
//
//  Created by Thonatas Borges on 04/01/21.
//

import UIKit
import GameplayKit

enum Sign: String {
    case rock
    case paper
    case scissors
}

func renameSignTextWithEmoction(sign: Sign) -> String {
    switch sign {
    case .rock:
       return "👊"
    case .paper:
       return "✋"
    case .scissors:
       return "✌️"
    }
}

func randomSign() -> Sign {
    let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)
    let sign = randomChoice.nextInt()
    print(sign)
    
    if sign == 0 {
        return .rock
    } else if sign == 1 {
        return .paper
    } else {
        return .scissors
    }
}
