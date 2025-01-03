//
//  ViewController.swift
//  pomodoroTimer
//
//  Created by user263078 on 12/31/24.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    
    var timeLeft = 0
    
    var timeChosenSec = 0
    
    

    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func timeSlider(_ sender: UISlider) {
        timeChosenSec = Int(sender.value) //the time chosen by the user sliding the slider
        print("Slider changing to \(timeChosenSec)")
        countDownLabel.text = "\(timeChosenSec)"
        timeLeft = timeChosenSec * 60
        countDownLabel.text = formatTime(seconds:timeLeft)
        print("Slider set to \(timeChosenSec) minutes (\(timeLeft) seconds)")
        timer.invalidate()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        timer.invalidate()
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              sender.alpha = 1.0
          }
        progressBar.progress = 1.0
        timeLeft = timeChosenSec * 60
        countDownLabel.text = formatTime(seconds: timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc func timerAction(){
        timeLeft -= 1
        if timeLeft > 0{
            progressBar.progress = Float(Float(timeLeft)/Float(timeChosenSec*60))
            countDownLabel.text = formatTime(seconds: timeLeft)        }else{
            timer.invalidate()
            countDownLabel.text = "Take a break!"
        }
    }
    
    func formatTime(seconds: Int) -> String {
            let minutes = seconds / 60
            let seconds = seconds % 60
            return String(format: "%02d:%02d", minutes, seconds)
    }


}

