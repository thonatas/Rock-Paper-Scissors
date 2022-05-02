//
//  SettingsViewController.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 5/2/22.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - UI Components
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = GameState.defeat.background
        view.layer.cornerRadius = 8
        view.layer.borderColor = GameState.draw.background.cgColor
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.text = "Linguagem"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gamesQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.text = "Melhor de"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let gamesQuantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var closeImageView: UIImageView = {
        let imageView = UIImageView()
        let color = UIColor(hex: "383838")
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(enabledColor)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("EN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(languagesButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var portuguesButton: UIButton = {
        let button = UIButton()
        button.setTitle("PT-BR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(languagesButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var threeGamesButton: UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(gamesButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var fiveGamesButton: UIButton = {
        let button = UIButton()
        button.setTitle("5", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(gamesButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sevenGamesButton: UIButton = {
        let button = UIButton()
        button.setTitle("7", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(gamesButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Aplicar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = enabledColor
        button.addTarget(self, action: #selector(applyNow), for: .touchUpInside)
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Constants and Variables
    private let languageKey = "languageKey"
    private let gamesKey = "gamesKey"
    private let enabledColor = GameState.defeat.buttonColor
    private let disabledColor = UIColor(hex: "383838").withAlphaComponent(0.4)
    private var languagesButtons = [UIButton]()
    private var gamesButtons = [UIButton]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        self.buildViewHierarchy()
        self.buildConstraints()
        self.languagesButtons = [englishButton, portuguesButton]
        self.gamesButtons = [threeGamesButton, fiveGamesButton, sevenGamesButton]
        self.setInitialUI()
    }
}

// MARK: - Functions
private extension SettingsViewController {
    func setInitialUI() {
        DispatchQueue.main.async {
            self.languagesButtons.forEach { self.setBackgroundButtonColor(with: $0, key: self.languageKey) }
            self.gamesButtons.forEach { self.setBackgroundButtonColor(with: $0, key: self.gamesKey) }
        }
    }
    
    @objc
    func closeTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    func languagesButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(sender.tag, forKey: languageKey)
        UserDefaults.standard.synchronize()
        setInitialUI()
    }
    
    @objc
    func gamesButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(sender.tag, forKey: gamesKey)
        UserDefaults.standard.synchronize()
        setInitialUI()
    }
    
    @objc
    func applyNow() {
        UIView.animate(withDuration: 0.5, delay: 0.2) {
            let mainWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            mainWindow?.rootViewController = GameViewController()
            mainWindow?.rootViewController?.dismiss(animated: true)
        }
    }
    
    func setBackgroundButtonColor(with button: UIButton, key: String) {
        let index = UserDefaults.standard.integer(forKey: key)
        button.backgroundColor = index == button.tag ? enabledColor : disabledColor
    }
}

// MARK: - Layout
private extension SettingsViewController {
    func buildViewHierarchy() {
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(closeImageView)
        backgroundView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(languageLabel)
        mainStackView.addArrangedSubview(languageStackView)
        languageStackView.addArrangedSubview(englishButton)
        languageStackView.addArrangedSubview(portuguesButton)
        mainStackView.addArrangedSubview(gamesQuantityLabel)
        mainStackView.addArrangedSubview(gamesQuantityStackView)
        gamesQuantityStackView.addArrangedSubview(threeGamesButton)
        gamesQuantityStackView.addArrangedSubview(fiveGamesButton)
        gamesQuantityStackView.addArrangedSubview(sevenGamesButton)
        mainStackView.addArrangedSubview(applyButton)
        mainStackView.setCustomSpacing(50, after: gamesQuantityStackView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            applyButton.heightAnchor.constraint(equalToConstant: 40),
            
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            closeImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            closeImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            closeImageView.widthAnchor.constraint(equalToConstant: 30),
            closeImageView.heightAnchor.constraint(equalToConstant: 30),
            
            mainStackView.topAnchor.constraint(equalTo: closeImageView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
            mainStackView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
}
