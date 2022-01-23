//
//  ViewController.swift
//  Brogatachi
//
//  Created by Blake Branvold on 1/22/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var Character: UIImageView!
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var BlueEggButton: UIButton!
    @IBOutlet weak var RedEggButton: UIButton!
    @IBOutlet weak var YellowEggButton: UIButton!
    
    
    
    var timeShifter = 0
    var tapShifter = 0
    
    var player: AVAudioPlayer?
    var timer = Timer()
    
    var characterColor = "Red"
    //characterColor MUST become RedEgg
    var backgroundImage = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playSound(file: "song1")

    }
    
    
    
    @IBAction func BlueEggPressed(_ sender: Any) {
        eggToNorm(color: "Blue")
    }
    
    @IBAction func RedEggPressed(_ sender: Any) {
        eggToNorm(color: "Red")
    }
    
    @IBAction func YellowEggPressed(_ sender: Any) {
        eggToNorm(color: "Yellow")
    }
    
    func eggToNorm(color: String){
        characterColor = color
        Character.image = UIImage(named:characterColor + " Bro Idle 1")
        backgroundImage = "Home"
        Background.image = UIImage(named:"Home Background")
        BlueEggButton.isHidden = true
        RedEggButton.isHidden = true
        YellowEggButton.isHidden = true
        Character.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        player?.stop()
        playSound(file: "mainLoop")
        
    }
    
    
    //new function
    @objc func timerAction(){
            if(timeShifter == 0 && backgroundImage == "Home"){
                timeShifter = 1
                Character.image = UIImage(named:characterColor + " Bro Idle 2")
            } else if(backgroundImage == "Home"){
                timeShifter = 0
                Character.image = UIImage(named:characterColor + " Bro Idle 1")
            }
        }

    func tapShift(){
        if(tapShifter < 2){
            tapShifter += 1
        } else{
            tapShifter = 0
            
        }
        
        if(backgroundImage == "Home"){
            Character.image = UIImage(named:characterColor + " Bro Idle " + String(tapShifter))
            
        } else if(backgroundImage == "Gym"){
            Character.image = UIImage(named:characterColor + " Bro Lifting " + String(tapShifter))
            
        } else if(backgroundImage == "Kitchen"){
            Character.image = UIImage(named:characterColor + " Bro Eating " + String(tapShifter))
            
        } else if (backgroundImage == "Library"){
            Character.image = UIImage(named:characterColor + " Bro Reading " + String(tapShifter))
            
        }
    }
    
    func playSound(file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    

    @IBAction func HomeButtomPressed(_ sender: Any) {
        backgroundImage = "Home"
        Background.image = UIImage(named:"Home Background")
    }
    @IBAction func GymButtonPressed(_ sender: Any) {
        backgroundImage = "Gym"
        Background.image = UIImage(named:"Gym Background")
    }
    
    @IBAction func FoodButtonPressed(_ sender: Any) {
        backgroundImage = "Kitchen"
        Background.image = UIImage(named:"Kitchen Background")
    }
    @IBAction func LibraryButtonPressed(_ sender: Any) {
    }
}

