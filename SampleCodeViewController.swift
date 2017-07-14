//
//  LupitaGameViewController.swift
//  Feelings Safari
//
//  Created by Kevin Tran on 7/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import AVFoundation

class LupitaGameViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var puzzleBox: UIImageView!
    @IBOutlet var score: UILabel!
    @IBOutlet var question: UILabel!
    
    //MARK: - Buttons
    @IBOutlet var greenAnswerButton: UIButton!
    @IBOutlet var yellowAnswerButton: UIButton!
    @IBOutlet var orangeAnswerButton: UIButton!
    @IBOutlet var blueAnswerButton: UIButton!
    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var soundButton: UIButton!
    @IBOutlet var nextQuestionButton: UIButton!
    
    //MARK: - Variables
    var gameCounter: Int = 0
    var soundIsOn = Bool()
    var bellIsOn = Bool()
    var allQuestions = LupitaQuestions()
    var chosenAnswer = String()
    var allAlerts = AlertTitle()
    var buttonColor = UIButton()
    var audioPlayer = AVAudioPlayer()
    var ringBellSound = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamePlay()
        playBackgroundMusic()
    }
    
    //MARK: - Actions
    @IBAction func answersPicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            buttonColor = greenAnswerButton
            chosenAnswer = allQuestions.possibleAnswers[gameCounter][0]
            checkAnswer()
        case 1:
            buttonColor = yellowAnswerButton
            chosenAnswer = allQuestions.possibleAnswers[gameCounter][1]
            checkAnswer()
        case 2:
            buttonColor = orangeAnswerButton
            chosenAnswer = allQuestions.possibleAnswers[gameCounter][2]
            checkAnswer()
        case 3:
            buttonColor = blueAnswerButton
            chosenAnswer = allQuestions.possibleAnswers[gameCounter][3]
            checkAnswer()
        default:
            buttonColor = blueAnswerButton
            chosenAnswer = allQuestions.possibleAnswers[gameCounter][3]
            checkAnswer()
        }
    }//end of answersPicked
    
    @IBAction func playAgainButtonPress(_ sender: UIButton) {
        gameCounter = 0
        dismiss(animated: true, completion: nil)
    }//end of playAgainButtonPress
    
    @IBAction func soundButtonPress(_ sender: UIButton) {
        if soundIsOn {
            soundButton.setImage(UIImage(named: "soundOff.png"), for: .normal)
            soundIsOn = false
            bellIsOn = false
            audioPlayer.pause()
        } else {
            soundButton.setImage(UIImage(named: "soundOn.png"), for: .normal)
            soundIsOn = true
            bellIsOn = true
            playBackgroundMusic()
        }
    }//end of soundButtonPress
    
    @IBAction func nextQuestionButtonPress(_ sender: UIButton) {
        gamePlay()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Functions
    func incrumentGameCounter() {
        gameCounter += 1
        if gameCounter >= allQuestions.questions.count {
            question.textAlignment = .center
            question.text = "Nice Work! We found all the animals!"
            hideAnswerButtons()
            playAgainButton.isHidden = false
        } else {
            question.text = allQuestions.questions[gameCounter]
            greenAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][0], for: UIControlState.normal)
            yellowAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][1], for: UIControlState.normal)
            orangeAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][2], for: UIControlState.normal)
            blueAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][3], for: UIControlState.normal)
        }
    }//end of incrumentGameCounter
    
    func checkAnswer() {
        if allQuestions.correctAnswers[gameCounter][chosenAnswer]! {
            incrumentGameCounter()
            freeAnimals()
        } else {
            shake(color: buttonColor)
        }
    }//end of checkAnswer
    
    func freeAnimals() {
        switch gameCounter {
        case 1..<4:
            freeGiraffe()
        case 4:
            score.text = "1/8"
            freeGiraffe()
            congratulatePlayer()
            nextQuestion(animal: "Giraffe")
        case 5..<8:
            freeGorilla()
        case 8:
            score.text = "2/8"
            freeGorilla()
            congratulatePlayer()
            nextQuestion(animal: "Gorilla")
        case 9..<12:
            freeRhino()
        case 12:
            score.text = "3/8"
            freeRhino()
            congratulatePlayer()
            nextQuestion(animal: "Rhino")
        case 13..<16:
            freeFox()
        case 16:
            score.text = "4/8"
            freeFox()
            congratulatePlayer()
            nextQuestion(animal: "Fox")
        case 17..<20:
            freeCrocodile()
        case 20:
            score.text = "5/8"
            freeCrocodile()
            congratulatePlayer()
            nextQuestion(animal: "Crocodile")
        case 21..<24:
            freeHippo()
        case 24:
            score.text = "6/8"
            freeHippo()
            congratulatePlayer()
            nextQuestion(animal: "Hippo")
        case 24..<28:
            freeZebra()
        case 28:
            score.text = "7/8"
            freeZebra()
            congratulatePlayer()
            nextQuestion(animal: "Zebra")
        case 29..<32:
            freeLion()
        case 32:
            score.text = "8/8"
            freeLion()
            congratulatePlayer()
        default:
            print("out of animals")
        }
    }//end of freeAnimals
    
    func congratulatePlayer() {
        playBellSound()
        emphasize(image: puzzleBox)
    }
    
    func freeGiraffe() {
        puzzleBox.image = UIImage(named: "giraffe\(gameCounter).png")
    }
    
    func freeGorilla() {
        puzzleBox.image = UIImage(named: "gorilla\(gameCounter).png")
    }
    
    func freeRhino() {
        puzzleBox.image = UIImage(named: "rhino\(gameCounter).png")
    }
    
    func freeFox() {
        puzzleBox.image = UIImage(named: "fox\(gameCounter).png")
    }
    
    func freeCrocodile() {
        puzzleBox.image = UIImage(named: "crocodile\(gameCounter).png")
    }
    
    func freeHippo() {
        puzzleBox.image = UIImage(named: "hippo\(gameCounter).png")
    }
    
    func freeZebra() {
        puzzleBox.image = UIImage(named: "zebra\(gameCounter).png")
    }
    
    func freeLion() {
        puzzleBox.image = UIImage(named: "lion\(gameCounter).png")
    }
    
    func playBackgroundMusic() {
        if soundIsOn {
            soundButton.setImage(UIImage(named: "soundOn.png"), for: .normal)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "rainbows", ofType: "mp3")!))
                audioPlayer.prepareToPlay()
            } catch {
                print(error)
            }
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        } else {
            soundButton.setImage(UIImage(named: "soundOff.png"), for: .normal)
        }
    }//end of playBackgroundMusic
    
    func playBellSound() {
        if bellIsOn {
            do {
                ringBellSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bell", ofType: "m4a")!))
                ringBellSound.prepareToPlay()
            } catch {
                print(error)
            }
            ringBellSound.play()
        } else {
            
        }
    }//end of playBellSound
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }//end of alert
    
    func shake(color: UIButton) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.9
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        color.layer.add(animation, forKey: "shake")
    }//end of shake animation
    
    func nextQuestion(animal: String) {
        question.textAlignment = .center
        question.text = "\(allAlerts.randomCorrect()) - We found the \(animal)!"
        hideAnswerButtons()
        nextQuestionButton.isHidden = false
    }//end of nextQuestion
    
    func hideAnswerButtons() {
        greenAnswerButton.isHidden = true
        yellowAnswerButton.isHidden = true
        orangeAnswerButton.isHidden = true
        blueAnswerButton.isHidden = true
    }//end of hideAnswerButtons
    
    func gamePlay() {
        puzzleBox.image = UIImage(named: "emptyPuzzle.png")
        playAgainButton.isHidden = true
        nextQuestionButton.isHidden = true
        question.text = allQuestions.questions[gameCounter]
        
        greenAnswerButton.titleLabel?.textAlignment = .center
        greenAnswerButton.titleLabel?.numberOfLines = 1
        greenAnswerButton.titleLabel?.minimumScaleFactor = 0.01
        greenAnswerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        yellowAnswerButton.titleLabel?.textAlignment = .center
        yellowAnswerButton.titleLabel?.numberOfLines = 1
        yellowAnswerButton.titleLabel?.minimumScaleFactor = 0.01
        yellowAnswerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        orangeAnswerButton.titleLabel?.textAlignment = .center
        orangeAnswerButton.titleLabel?.numberOfLines = 1
        orangeAnswerButton.titleLabel?.minimumScaleFactor = 0.01
        orangeAnswerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        blueAnswerButton.titleLabel?.textAlignment = .center
        blueAnswerButton.titleLabel?.numberOfLines = 1
        blueAnswerButton.titleLabel?.minimumScaleFactor = 0.01
        blueAnswerButton.titleLabel?.adjustsFontSizeToFitWidth = true
  
        greenAnswerButton.isHidden = false
        yellowAnswerButton.isHidden = false
        orangeAnswerButton.isHidden = false
        blueAnswerButton.isHidden = false
        greenAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][0], for: UIControlState.normal)
        yellowAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][1], for: UIControlState.normal)
        orangeAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][2], for: UIControlState.normal)
        blueAnswerButton.setTitle(allQuestions.possibleAnswers[gameCounter][3], for: UIControlState.normal)
    }//end of gamePlay
    
    func emphasize(image: UIImageView) {
        let bounds = image.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            image.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (success: Bool) in
            if success {
                image.bounds = bounds
            }
        }
    }//end of emphasize
    

}//end of LupitaGameViewController
