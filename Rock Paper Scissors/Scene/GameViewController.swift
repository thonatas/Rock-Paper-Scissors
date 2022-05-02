//
//  GameViewController.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 05/01/21.
//

import UIKit
import GameplayKit

class GameViewController: UIViewController {
    //MARK: - UI Components
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scoreboardView: ScoreboardView = {
        let scoreboardView = ScoreboardView()
        scoreboardView.translatesAutoresizingMaskIntoConstraints = false
        return scoreboardView
    }()
    
    private lazy var settingsImageView: UIImageView = {
        let imageView = UIImageView()
        let color = UIColor(hex: "383838")
        let tap = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "gearshape.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(color)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var robotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var robotChoiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gameStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .regular)
        label.text = GameState.start.title
        label.textColor = .black
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
        imageView.image = Sign.rock.userIcon
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
        imageView.image = Sign.paper.userIcon
        imageView.tag = Sign.paper.tag
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scissorsImageView: UIImageView = {
        let imageView = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(userChoiceButtonPressed(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.image = Sign.scissors.userIcon
        imageView.tag = Sign.scissors.tag
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nextTurnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Próxima Rodada", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(nextTurnButtonTapped), for: .touchUpInside)
        button.isHidden = true
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants and Variables
    private var userImagesViews = [UIImageView]()
    private var userScore = 0
    private var robotScore = 0
    private var maximumGamesQuantity: Int?
    private var resultGame = GameState.start {
        didSet {
            if resultGame == .victory || resultGame == .defeat {
                let viewController = SettingsViewController()
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildViewHierarchy()
        self.buildConstraints()
        self.setInitialUI()
        self.setRobotImage()
        self.scoreboardView.setup()
        self.userImagesViews = [rockImageView, paperImageView, scissorsImageView]
        self.getGamesQuantity()
    }
}

// MARK: - Functions
private extension GameViewController {
    func setInitialUI() {
        changeLayoutByState(.start)
        hideUserButtons(false)
    }
    
    func setRobotImage() {
        let index = GKRandomDistribution(lowestValue: 1, highestValue: 15).nextInt()
        robotImageView.image = UIImage(named: "robot-\(index)")
    }
    
    func getGamesQuantity() {
        let gamesQuantities = [3, 5, 7]
        let index = UserDefaults.standard.integer(forKey: "gamesKey")
        self.maximumGamesQuantity = gamesQuantities[index]
    }
    
    func hideUserButtons(_ isHidden: Bool) {
        self.userImagesViews.forEach { imageView in
            imageView.isHidden = isHidden
            imageView.isUserInteractionEnabled = !isHidden
        }
        self.nextTurnButton.isHidden = !isHidden
        self.robotChoiceImageView.isHidden = !isHidden
        self.settingsImageView.isHidden = isHidden
    }
    
    @objc
    func settingsTapped() {
        let viewController = SettingsViewController()
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true)
    }
    
    @objc
    func userChoiceButtonPressed(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let signSelected = Sign.allCases[view.tag]
        playGame(signSelected)
        hideUserButtons(true)
        view.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    @objc
    func nextTurnButtonTapped() {
        hideUserButtons(false)
        setInitialUI()
    }
    
    func playGame(_ userChoice: Sign) {
        let statusOfGame = userChoice.statusOfGame()
        let gameState = statusOfGame.gameState
        let robotChoice = statusOfGame.robotChoice
        changeLayoutByState(gameState)
        robotChoiceImageView.image = robotChoice.robotIcon
        nextTurnButton.backgroundColor = gameState.buttonColor
        nextTurnButton.setTitleColor(gameState == .draw ? .darkGray : .white, for: .normal)
        setScoreGame(gameState)
    }
    
    func changeLayoutByState(_ gameState: GameState) {
        view.backgroundColor = gameState.background
        gameStateLabel.text = gameState.title
    }
    
    func setScoreGame(_ state: GameState) {
        if state == .victory {
            userScore += 1
        }
        if state == .defeat {
            robotScore += 1
        }
        scoreboardView.setup(userScore: userScore, robotScore: robotScore)
        scoreboardView.layoutIfNeeded()
        goResultGame()
    }
    
    func goResultGame() {
        guard let maximumGamesQuantity = maximumGamesQuantity else { return }
        if userScore == maximumGamesQuantity {
            self.resultGame = .victory
        }
        if robotScore == maximumGamesQuantity {
            self.resultGame = .defeat
        }
    }
}

// MARK: - Layout
private extension GameViewController {
    func buildViewHierarchy() {
        self.view.addSubview(backgroundView)
        self.view.addSubview(scoreboardView)
        self.view.addSubview(settingsImageView)
        self.view.addSubview(robotImageView)
        self.view.addSubview(robotChoiceImageView)
        self.view.addSubview(gameStateLabel)
        self.view.addSubview(buttonsStackView)
        self.buttonsStackView.addArrangedSubview(rockImageView)
        self.buttonsStackView.addArrangedSubview(paperImageView)
        self.buttonsStackView.addArrangedSubview(scissorsImageView)
        self.view.addSubview(nextTurnButton)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            settingsImageView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsImageView.widthAnchor.constraint(equalToConstant: 50),
            settingsImageView.heightAnchor.constraint(equalToConstant: 50),
            
            scoreboardView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreboardView.widthAnchor.constraint(equalToConstant: 150),
            scoreboardView.heightAnchor.constraint(equalToConstant: 50),
            
            robotImageView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            robotImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotImageView.widthAnchor.constraint(equalToConstant: 140),
            
            backgroundView.centerXAnchor.constraint(equalTo: robotImageView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: robotImageView.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 160),
            backgroundView.heightAnchor.constraint(equalToConstant: 160),
            
            robotChoiceImageView.topAnchor.constraint(greaterThanOrEqualTo: robotImageView.bottomAnchor, constant: 80),
            robotChoiceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotChoiceImageView.widthAnchor.constraint(equalToConstant: 75),
            robotChoiceImageView.heightAnchor.constraint(equalToConstant: 75),
            
            gameStateLabel.topAnchor.constraint(equalTo: robotChoiceImageView.bottomAnchor, constant: 10),
            gameStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gameStateLabel.heightAnchor.constraint(equalToConstant: 75),
            
            buttonsStackView.topAnchor.constraint(equalTo: gameStateLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 75),
            
            nextTurnButton.topAnchor.constraint(greaterThanOrEqualTo: buttonsStackView.bottomAnchor, constant: 40),
            nextTurnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextTurnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextTurnButton.heightAnchor.constraint(equalToConstant: 50),
            nextTurnButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        self.backgroundView.sendSubviewToBack(robotImageView)
    }
}
