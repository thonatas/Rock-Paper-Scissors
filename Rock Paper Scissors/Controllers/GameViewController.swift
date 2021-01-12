//
//  GameViewController.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 05/01/21.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Attributes
    let textsGameState = ["Rock, Paper or Scissors?", "Won 😄!", "You lost 🙁!", "Draw 😐!!!"]
    let colors = [#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
    
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
    @IBAction func userChoiceButtonPressed(_ sender: UIButton) {
        guard let userChoice = sender.currentTitle else { return }

        playGame(userChoice)
        hideUserButtons(true)
        sender.isHidden.toggle()
        sender.isEnabled = false
        enableTextFieldsButton(false)

    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        hideUserButtons(false)
        enableUserButtons()
        changeLayoutByState(keyState: 0)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLayoutByState(keyState: 0)
        enableUserButtons()
        updateUI()
    }

    // MARK: - Methods
    func playGame(_ userChoice: String) {
        let robotChoice = randomSign()
        let result = statusOfGame(userChoice, robotChoice)
        changeLayoutByState(keyState: result.rawValue)
        textFieldRobotSign.text = robotChoice
    }
    
    func changeLayoutByState(keyState: Int) {
        viewBackground.backgroundColor = colors[keyState]
        textFieldGameState.text = textsGameState[keyState]
    }
    
    func hideUserButtons(_ isHidden: Bool) {
        buttonPaper.isHidden = isHidden
        buttonRock.isHidden = isHidden
        buttonScissors.isHidden = isHidden
        buttonPlayAgain.isHidden.toggle()
        textFieldRobotSign.isHidden = !isHidden
    }
    
    func enableUserButtons() {
        buttonPaper.isEnabled = true
        buttonRock.isEnabled = true
        buttonScissors.isEnabled = true
    }
    
    func enableTextFieldsButton(_ isEnable: Bool) {
        textFieldRobot.isEnabled = isEnable
        textFieldRobotSign.isEnabled = isEnable
        textFieldGameState.isEnabled = isEnable
    }
    
    func updateUI() {
        buttonPlayAgain.isHidden = true
        textFieldRobotSign.isHidden = true
        textFieldRobotSign.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}
