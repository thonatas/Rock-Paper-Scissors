//
//  ViewController.swift
//  jogo-pedra-papel-e-tesoura
//
//  Created by Thonatas Borges on 04/01/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Attributes
    var signOfRobot: Sign?
    var colorStartState = UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1)
    var colorVictoryState = UIColor(red: 0.0/255.0, green: 147.0/255.0, blue: 80.0/255.0, alpha: 1)
    var colorDefeatState = UIColor(red: 255.0/255.0, green: 126.0/255.0, blue: 121.0/255.0, alpha: 1)
    var colorDrawState = UIColor(red: 118.0/255.0, green: 214.0/255.0, blue: 255.0/255.0, alpha: 1)
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldRobot: UITextField!
    @IBOutlet weak var textFieldRobotSign: UITextField!
    @IBOutlet weak var textFieldGameState: UITextField!
    @IBOutlet weak var buttonRock: UIButton!
    @IBOutlet weak var buttonPaper: UIButton!
    @IBOutlet weak var buttonScissors: UIButton!
    @IBOutlet weak var buttonPlayAgain: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    
    // MARK: - Actions
    @IBAction func userChoiceRock(_ sender: UIButton) {
        playGame(userChoice: .rock)
        buttonPaper.isHidden = true
        buttonScissors.isHidden = true
    }
    
    @IBAction func userChoicePaper(_ sender: UIButton) {
        playGame(userChoice: .paper)
        buttonRock.isHidden = true
        buttonScissors.isHidden = true
    }
    
    @IBAction func userChoiceScissors(_ sender: UIButton) {
        playGame(userChoice: .scissors)
        buttonPaper.isHidden = true
        buttonRock.isHidden = true
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        buttonPaper.isHidden = false
        buttonRock.isHidden = false
        buttonScissors.isHidden = false
        textFieldRobotSign.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        changeLayoutByState(gameState: .start, gameStateText: "Rock, Paper or Scissors?", backgroundColor: colorStartState, statusIsHiddenButtonPlayAgain: true)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLayoutByState(gameState: .start, gameStateText: "Rock, Paper or Scissors?", backgroundColor: colorStartState, statusIsHiddenButtonPlayAgain: true)
        buttonPlayAgain.isHidden = true
        textFieldRobotSign.isHidden = true
    }

    // MARK: - Methods
    func statusOfGame(userChoice: Sign) -> GameState {
        let randomChoiceOfRobot = randomSign()
        signOfRobot = randomChoiceOfRobot
        
        if randomChoiceOfRobot == userChoice {
            return .draw
            
        } else {
            switch userChoice {
            case .rock:
                if randomChoiceOfRobot == .scissors {
                    return .victory
                }
                break
            case .paper:
                if randomChoiceOfRobot == .rock {
                    return .victory
                }
                break
            case .scissors:
                if randomChoiceOfRobot == .paper {
                    return .victory
                }
                break
            }
            return .defeat
        }
    }
    
    func playGame(userChoice: Sign) {
        let result = statusOfGame(userChoice: userChoice)
        switch result {
        case .start:
            changeLayoutByState(gameState: .start, gameStateText: "Rock, Paper or Scissors?", backgroundColor: colorStartState, statusIsHiddenButtonPlayAgain: true)
            break
        case .victory:
            changeLayoutByState(gameState: .victory, gameStateText: "Won 😄!", backgroundColor: colorVictoryState, statusIsHiddenButtonPlayAgain: false)
            break
        case .defeat:
            changeLayoutByState(gameState: .defeat, gameStateText: "You lost 🙁!", backgroundColor: colorDefeatState, statusIsHiddenButtonPlayAgain: false)
            break
        case .draw:
            changeLayoutByState(gameState: .draw, gameStateText: "Draw 😐!!!", backgroundColor: colorDrawState, statusIsHiddenButtonPlayAgain: false)
            break
        }
    }
    
    func changeLayoutByState(gameState: GameState, gameStateText: String, backgroundColor: UIColor, statusIsHiddenButtonPlayAgain: Bool) {
        
        guard let randomChoiceOfRobot = signOfRobot else { return }
        viewBackground.backgroundColor = backgroundColor
        
        if gameState == .start {
            textFieldRobotSign.isHidden = true
        } else {
            textFieldRobotSign.isHidden = false
            textFieldRobotSign.text = renameSignTextWithEmoction(sign: randomChoiceOfRobot)
            textFieldRobotSign.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        textFieldRobot.text = "🤖"
        textFieldGameState.text = gameStateText
        buttonPlayAgain.isHidden = statusIsHiddenButtonPlayAgain

    }
    
    //    func changeLayoutForStatusStart() {
    //        viewBackground.backgroundColor = UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1)
    //        textFieldRobotSign.text = "🤖"
    //        textFieldGameState.text = "Rock, Paper or Scissors?"
    //        buttonPlayAgain.isHidden = true
    //        buttonPaper.isHidden = false
    //        buttonRock.isHidden = false
    //        buttonScissors.isHidden = false
    //    }
    //
    //    func changeLayoutForStatusVictory() {
    //        guard let randomChoiceOfRobot = signOfRobot else { return }
    //
    //        viewBackground.backgroundColor = UIColor(red: 0.0/255.0, green: 147.0/255.0, blue: 80.0/255.0, alpha: 1)
    //        textFieldRobotSign.text = renameSignTextWithEmoction(sign: randomChoiceOfRobot)
    //        textFieldGameState.text = "Won 😄!"
    //        buttonPlayAgain.isHidden = false
    //    }
    //
    //    func changeLayoutForStatusDefeat() {
    //        guard let randomChoiceOfRobot = signOfRobot else { return }
    //
    //        viewBackground.backgroundColor = UIColor(red: 255.0/255.0, green: 126.0/255.0, blue: 121.0/255.0, alpha: 1)
    //        textFieldRobotSign.text = renameSignTextWithEmoction(sign: randomChoiceOfRobot)
    //        textFieldGameState.text = "You lost 🙁!"
    //        buttonPlayAgain.isHidden = false
    //    }
    //
    //    func changeLayoutForStatusDraw() {
    //        guard let randomChoiceOfRobot = signOfRobot else { return }
    //
    //        viewBackground.backgroundColor = UIColor(red: 118.0/255.0, green: 214.0/255.0, blue: 255.0/255.0, alpha: 1)
    //        textFieldRobotSign.text = renameSignTextWithEmoction(sign: randomChoiceOfRobot)
    //        textFieldGameState.text = "Draw 😐!!!"
    //        buttonPlayAgain.isHidden = false
    //    }
}

