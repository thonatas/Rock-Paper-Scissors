//
//  GameViewController.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 05/01/21.
//

import UIKit

class GameViewController: UIViewController {
    //MARK: - UI Components
    private lazy var robotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "heart")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var robotChoiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "star.fill")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gameStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .regular)
        label.text = GameState.start.title
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var rockImageView: UIImageView = {
        let imageView = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(userChoiceButtonPressed(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.image = Sign.rock.icon
        imageView.tag = Sign.rock.tag
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var paperImageView: UIImageView = {
        let imageView = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(userChoiceButtonPressed(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.image = Sign.paper.icon
        imageView.tag = Sign.paper.tag
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scissorsImageView: UIImageView = {
        let imageView = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(userChoiceButtonPressed(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.image = Sign.scissors.icon
        imageView.tag = Sign.scissors.tag
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var playAgainButtom: UIButton = {
        let button = UIButton()
        button.setTitle("Play Again", for: .normal)
        button.addTarget(self, action: #selector(playAgainButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Actions
    @objc
    private func userChoiceButtonPressed(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        print(Sign.allCases[tag])
//        guard let userChoice = sender.currentTitle else { return }
//        playGame(userChoice)
//        hideUserButtons(true)
//        sender.isHidden.toggle()
//        sender.isEnabled = false
//        enableTextFieldsButton(false)

    }
    
    @objc
    private func playAgainButton() {
//        hideUserButtons(false)
//        enableUserButtons()
//        changeLayoutByState(keyState: 0)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildViewHierarchy()
        self.buildConstraints()
        self.view.backgroundColor = GameState.start.background
    }

    // MARK: - Methods
//    func playGame(_ userChoice: String) {
//        let robotChoice = randomSign()
//        let result = statusOfGame(userChoice, robotChoice)
//        changeLayoutByState(keyState: result.rawValue)
//        textFieldRobotSign.text = robotChoice
//    }
//
//    func changeLayoutByState(keyState: Int) {
//        viewBackground.backgroundColor = colors[keyState]
//        textFieldGameState.text = textsGameState[keyState]
//    }
//
//    func hideUserButtons(_ isHidden: Bool) {
//        buttonPaper.isHidden = isHidden
//        buttonRock.isHidden = isHidden
//        buttonScissors.isHidden = isHidden
//        buttonPlayAgain.isHidden.toggle()
//        textFieldRobotSign.isHidden = !isHidden
//    }
//
//    func enableUserButtons() {
//        buttonPaper.isEnabled = true
//        buttonRock.isEnabled = true
//        buttonScissors.isEnabled = true
//    }
//
//    func enableTextFieldsButton(_ isEnable: Bool) {
//        textFieldRobot.isEnabled = isEnable
//        textFieldRobotSign.isEnabled = isEnable
//        textFieldGameState.isEnabled = isEnable
//    }
//
//    func updateUI() {
//        buttonPlayAgain.isHidden = true
//        textFieldRobotSign.isHidden = true
//        textFieldRobotSign.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//    }
}

// MARK: - Layout
extension GameViewController {
    func buildViewHierarchy() {
        self.view.addSubview(robotImageView)
        self.view.addSubview(robotChoiceImageView)
        self.view.addSubview(gameStateLabel)
        self.view.addSubview(buttonsStackView)
        self.buttonsStackView.addArrangedSubview(rockImageView)
        self.buttonsStackView.addArrangedSubview(paperImageView)
        self.buttonsStackView.addArrangedSubview(scissorsImageView)
        self.view.addSubview(playAgainButtom)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            robotImageView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            robotImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotImageView.widthAnchor.constraint(equalToConstant: 100),
            robotImageView.heightAnchor.constraint(equalToConstant: 100),
            
            robotChoiceImageView.topAnchor.constraint(equalTo: robotImageView.bottomAnchor, constant: 20),
            robotChoiceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotChoiceImageView.widthAnchor.constraint(equalToConstant: 100),
            robotChoiceImageView.heightAnchor.constraint(equalToConstant: 100),
            
            gameStateLabel.topAnchor.constraint(equalTo: robotChoiceImageView.bottomAnchor, constant: 10),
            gameStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gameStateLabel.heightAnchor.constraint(equalToConstant: 75),
            
            buttonsStackView.topAnchor.constraint(equalTo: gameStateLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100),
            
            playAgainButtom.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            playAgainButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playAgainButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            playAgainButtom.heightAnchor.constraint(equalToConstant: 50),
            playAgainButtom.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100)
        ])
    }
}
