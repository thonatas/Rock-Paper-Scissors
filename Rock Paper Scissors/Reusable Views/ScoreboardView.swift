//
//  ScoreboardView.swift
//  Rock Paper Scissors
//
//  Created by Thonatas Borges on 5/2/22.
//

import UIKit

class ScoreboardView: UIView {
    //MARK: - UI Components
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        backgroundColor = .black.withAlphaComponent(0.5)
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.gray.withAlphaComponent(0.8).cgColor
        buildViewHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(userScore: Int = 0, robotScore: Int = 0) {
        self.scoreLabel.text = "😁 \(userScore) X \(robotScore) 🤖"
    }
}

// MARK: - Views and Constraints
extension ScoreboardView {
    func buildViewHierarchy() {
        self.addSubview(scoreLabel)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: self.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


