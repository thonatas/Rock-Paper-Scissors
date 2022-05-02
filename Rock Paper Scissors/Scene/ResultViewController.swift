//
//  ResultViewController.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 5/2/22.
//

import UIKit
import Lottie

protocol ResultViewControllerDelegate: AnyObject {
    func didGetResult()
}

class ResultViewController: UIViewController {
    //MARK: - UI Components
    private lazy var animationView: LOTAnimationView = {
        let uiview = LOTAnimationView(name: "winner", bundle: Bundle(for: ResultViewController.self))
        uiview.contentMode = .scaleAspectFit
        uiview.loopAnimation = true
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    }()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.text = "Resultado"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Jogar Novamente", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(playAgainButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants and Variables
    private var state: GameState?
    weak var delegate: ResultViewControllerDelegate?
    
    // MARK: - Initializers
    init(state: GameState) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildViewHierarchy()
        self.buildConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitiateUI()
        self.showAnimation(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showAnimation(false)
        }
    }
}

// MARK: - Functions
private extension ResultViewController {
    @objc
    func playAgainButtonTapped() {
        self.delegate?.didGetResult()
        self.dismiss(animated: true)
    }
}

// MARK: - Layout
private extension ResultViewController {
    func buildViewHierarchy() {
        self.view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(resultLabel)
        mainStackView.addArrangedSubview(playAgainButton)
        mainStackView.setCustomSpacing(50, after: resultLabel)
        self.view.addSubview(animationView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            playAgainButton.heightAnchor.constraint(equalToConstant: 50),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setInitiateUI() {
        guard let state = state else { return }
        self.animationView.setAnimation(named: state == .victory ? "winner" : "loser")
        self.animationView.backgroundColor = state.background
        self.resultLabel.text = state.resultText
        self.view.backgroundColor = state.background
        self.playAgainButton.backgroundColor = state.buttonColor
    }
}

// MARK: - Animation
extension ResultViewController {
    public func showAnimation(_ isShown: Bool = true) {
        isShown ? startAnimating() : stopAnimating()
    }
    
    private func startAnimating() {
        animationView.animationProgress = 0.20
        animationView.play()
        UIView.animate(withDuration: 0.2) {
            self.animationView.alpha = 1
        }
    }
    
    private func stopAnimating() {
        UIView.animate(withDuration: 0.2) {
            self.animationView.alpha = 0
        } completion: { [animationView] _ in
            animationView.stop()
        }
    }
}
