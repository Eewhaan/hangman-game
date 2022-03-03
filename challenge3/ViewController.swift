//
//  ViewController.swift
//  challenge3
//
//  Created by Ivan Pavic on 17.1.22..
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var guideLabel: UITextField!
    var letterButtons = [UIButton]()
    var lifeCountLabel: UILabel!
    var hangImage: UIImageView!
    var answersView: UIView!
    var answerButtons = [UIButton]()
    var answerViewConstraint = NSLayoutConstraint()
    var buttonsView: UIView!
    
    var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "", "", "Y", "Z", "", ""]
    var currentWord = ""
    var currentWordLetters = [String]()
    var previousWords = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var lifeCount = 7 {
        didSet {
            lifeCountLabel.text = "Remaining lives: \(lifeCount)"
            hangImage.image = UIImage(named: "hangman\(lifeCount)")
        }
    }
    
    var portraitConstraints = [NSLayoutConstraint]()
    var landscapeConstraints = [NSLayoutConstraint]()
    
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        scoreLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(scoreLabel)
        
        lifeCountLabel = UILabel()
        lifeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeCountLabel.text = "Remaining lives: 7"
        lifeCountLabel.textAlignment = .left
        lifeCountLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(lifeCountLabel)
        
        hangImage = UIImageView()
        hangImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hangImage)
        
        guideLabel = UITextField()
        guideLabel.translatesAutoresizingMaskIntoConstraints = false
        guideLabel.placeholder = "Tap letter to guess"
        guideLabel.font = UIFont.systemFont(ofSize: 30)
        guideLabel.textAlignment = .center
        guideLabel.isUserInteractionEnabled = false
        view.addSubview(guideLabel)
        
        
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        answersView = UIView()
        answersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answersView)
        
        portraitConstraints = [
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            scoreLabel.centerYAnchor.constraint(equalTo: lifeCountLabel.centerYAnchor),
            
            lifeCountLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor),
            lifeCountLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            hangImage.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            hangImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            guideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guideLabel.topAnchor.constraint(equalTo: hangImage.bottomAnchor, constant: 5),
            
            answersView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answersView.topAnchor.constraint(equalTo: guideLabel.topAnchor, constant: 3),
            
            buttonsView.topAnchor.constraint(equalTo: answersView.topAnchor, constant: 40),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            buttonsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
        ]
        
        landscapeConstraints = [
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            scoreLabel.centerYAnchor.constraint(equalTo: lifeCountLabel.centerYAnchor),
            
            lifeCountLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor),
            lifeCountLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            hangImage.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5),
            hangImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            hangImage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 5),
            
            
            guideLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 60),
            guideLabel.topAnchor.constraint(equalTo: lifeCountLabel.bottomAnchor, constant: 25),
            
            answersView.centerXAnchor.constraint(equalTo: guideLabel.centerXAnchor),
            answersView.topAnchor.constraint(equalTo: guideLabel.topAnchor, constant: 25),
            
            buttonsView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 40),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.centerXAnchor.constraint(equalTo: guideLabel.centerXAnchor),
            buttonsView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            buttonsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
        ]
        
        if UIScreen.main.isPortrait() {
            activatePortraitConstraints()
        } else {
            activateLandscapeConstraints()
        }
        
        let width = 50
        let height = 40
        let counter = 6
        
        for row in 0..<5 {
            for column in 0..<6 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                letterButton.setTitle(letters[column + row * counter], for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                letterButton.layer.borderWidth = 0.5
                letterButton.layer.borderColor = UIColor.gray.cgColor
                letterButton.setTitleColor(UIColor.black, for: .normal)
                let frame = CGRect(x: column * width, y: row * height, width: width - 1, height: height - 1)
                letterButton.frame = frame
                
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                
                if letterButton.currentTitle == "" {
                    letterButton.isHidden = true
                }
            }
        }
        
        hangImage.image = UIImage(named: "hangman7")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))

        loadLevel()


    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            activatePortraitConstraints()
        } else {
            activateLandscapeConstraints()
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        
        guideLabel.isHidden = true
        
        guard let buttonTapped = sender.titleLabel?.text else {return}
        if currentWordLetters.contains(buttonTapped) {
            sender.isEnabled = false
            sender.layer.backgroundColor = UIColor.green.cgColor
            for _ in 0..<currentWordLetters.count {
                guard let index = currentWordLetters.firstIndex(of: buttonTapped) else {return}
                answerButtons[index].setTitle(buttonTapped, for: .normal)
                currentWordLetters.insert("", at: index)
                currentWordLetters.remove(at: index + 1)
                score += 1
                if score == answerButtons.count {
                    let ac = UIAlertController(title: "Congratulations!", message: "That's the word we were looking for!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Next word", style: .default, handler: newGame))
                    present (ac, animated: true)
                }
            }
        } else {
            lifeCount -= 1
            sender.isEnabled = false
            sender.layer.backgroundColor = UIColor.red.cgColor
            if lifeCount == 0 {
                let ac = UIAlertController(title: "Game Over", message: "Ooops, you've been hanged!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again?", style: .default, handler: outOfTries))
                ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: newGame))
                present (ac, animated: true)
            }
        }
    }
    
    func outOfTries (action: UIAlertAction) {
        
        resetAll(title: "_")
        guideLabel.isHidden = false
        
        let lettersOfSolution = Array(currentWord)
        for i in 0..<answerButtons.count {
            let str = String(lettersOfSolution[i])
            currentWordLetters.append(str)
        }
    }
    
    func loadLevel () {
        
        answersView.removeConstraint(answerViewConstraint)
        let dimension = 25
        
        if let FIleURL = Bundle.main.url(forResource: "challenge3 file", withExtension: ".txt") {
            if let fileContents = try? String(contentsOf: FIleURL) {
                var levels = fileContents.components(separatedBy: "\n")
                levels.shuffle()
                var randomWord: String
                repeat {
                    guard let word = levels.randomElement()?.uppercased() else {return}
                    randomWord = word
                } while previousWords.contains(randomWord)
                let lettersOfSOlution = Array(randomWord)
                currentWord = randomWord
                for i in 0..<lettersOfSOlution.count {
                    let str = String(lettersOfSOlution[i])
                    currentWordLetters.append(str)
                }
                
                for i in 0..<currentWordLetters.count {
                    let answerLetter = UIButton(type: .system)
                    answerLetter.setTitle("_", for: .normal)
                    answerLetter.setTitleColor(.black, for: .normal)
                    answerLetter.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            
                    answerButtons.append(answerLetter)
            
                    let frame = CGRect(x: i * dimension, y: 10, width: dimension, height: dimension)
                    answerButtons[i].frame = frame
            
                    answersView.addSubview(answerButtons[i])
                    
                }
            }
        }
        answerViewConstraint = answersView.widthAnchor.constraint(equalToConstant: CGFloat(currentWordLetters.count * dimension))
        answersView.addConstraint(answerViewConstraint)
        answerViewConstraint.isActive = true
    }
    
    @objc func newGame(action: UIAlertAction) {
        
        previousWords.append(currentWord)
        // empty previousWord array when we run out of words so we don't enter infinite loop
        if previousWords.count == 27 {
            previousWords.removeAll()
        }
        guideLabel.isHidden = false
        resetAll(title: nil)
        answerButtons.removeAll()
        currentWord = ""
        loadLevel()
    }
    
    func resetAll (title: String?) {
        
        lifeCount = 7
        score = 0
        for button in letterButtons {
            button.isEnabled = true
            button.layer.backgroundColor = UIColor.clear.cgColor
        }
        for i in 0..<answerButtons.count {
            answerButtons[i].setTitle(title, for: .normal)
        }
        currentWordLetters.removeAll()
    }
}

