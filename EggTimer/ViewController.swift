//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player: AVAudioPlayer?
    let eggTimes = ["Soft": 10, "Medium": 20, "Hard": 30]
    
    var secondsRemaining = 0
    var secondsPassed = 0
    var timer = Timer()
    
    
    //MARK: - Selecting Hardness
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        
        player?.stop()
        
        let hardness = sender.currentTitle!
        mainLabel.text = "In process."
        mainLabel.backgroundColor = UIColor.white.withAlphaComponent(0.4)
       
        secondsRemaining = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0 , target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //MARK: -  Update timer function
        @objc func updateTimer() {
            
            if secondsPassed < secondsRemaining {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(secondsRemaining)
            } else {
                timer.invalidate()
                mainLabel.text = "DONE"
                mainLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).withAlphaComponent(0.8)
                playSound(sound: "I Got You I Feel Good  - James Brown")
            }
            
        }
    
    //MARK: -  Play sound function
    func playSound(sound: String) {
        
        let url = Bundle.main.url(forResource: sound,  withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
      }
    
    }

