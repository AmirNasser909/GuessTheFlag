//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by MacBook Air on 24/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var NavItem: UINavigationItem!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score Share", style: .plain, target: self, action: #selector(shareTapped))
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
        questionNumber += 1
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
    
        if questionNumber < 10{
            if sender.tag == correctAnswer{
                title = "Correct"
                score += 1
            }else{
                title = "Wrong MISTAKE"
                score -= 1
            }
            NavItem.title = String(score)
            let ac = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }else{
            title = "END"
            let ac = UIAlertController(title: title, message: "final q Your Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default))
            present(ac, animated: true)
            questionNumber = 0
            score = 0
        }
    }
    @objc func shareTapped(){
        let score = "Score is \(score)"
        let activityViewController = UIActivityViewController(activityItems: [score], applicationActivities: [])
        present(activityViewController, animated: true, completion: nil)
    }
}

