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
    @IBOutlet weak var HatchTipLabel: UILabel!
    
    
    
    var timeShifter = 0
    var tapShifter = 1
    
    var player: AVAudioPlayer?
    var effectPlayer: AVAudioPlayer?
    var timer = Timer()
    var tapCount = 0
    var isEgging = false
    
    var characterColor = "Red"
    //characterColor MUST become RedEgg
    var backgroundImage = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playSound(file: "song1")

    }
    
    
    
    @IBAction func BlueEggPressed(_ sender: Any) {
        eggCracking(color: "Blue")
    }
    
    @IBAction func RedEggPressed(_ sender: Any) {
        eggCracking(color: "Red")
    }
    
    @IBAction func YellowEggPressed(_ sender: Any) {
        eggCracking(color: "Yellow")
    }
    
    
    func eggCracking(color: String){
        characterColor = color
        isEgging = true
        HatchTipLabel.isHidden = false
        BlueEggButton.isHidden = true
        RedEggButton.isHidden = true
        YellowEggButton.isHidden = true
        Character.isHidden = false
        Character.image = UIImage(named: characterColor + " Egg 1")
        Character.isHidden = false
        
        
        
    }
    
    @IBAction func InvisibleButtonPressed(_ sender: Any) {
        tapCount += 1
        if(isEgging){
            playSoundEffect(file: "tapShort")
            if(tapCount == 10){
                Character.image = UIImage(named: characterColor + " Egg 2")
                playSoundEffect(file: "tap")
            }
            if(tapCount == 20){
                Character.image = UIImage(named: characterColor + " Egg 3")
                playSoundEffect(file: "tap")
            }
            if(tapCount == 30){
                Character.image = UIImage(named: characterColor + " Egg 3")
                playSoundEffect(file: "tap")
            }
            if(tapCount == 40){
                Character.image = UIImage(named: characterColor + " Egg 4")
                playSoundEffect(file: "tap")
            }
            if(tapCount == 50){
                playSoundEffect(file: "tap")
                eggToNorm()
            }
        } else{
            tapShift()
        }
    }
    
    
    func eggToNorm(){
        isEgging = false
        HatchTipLabel.isHidden = true
        Character.image = UIImage(named:characterColor + " Bro Idle 1")
        backgroundImage = "Home"
        Background.image = UIImage(named:"Home Background")
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
        print("tapShift")
        print(backgroundImage)
        if(tapShifter < 3){
            tapShifter += 1
        } else{
            tapShifter = 1
            
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
    
    func playSoundEffect(file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            effectPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let effectPlayer = effectPlayer else { return }

            effectPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    

    @IBAction func HomeButtomPressed(_ sender: Any) {
        backgroundImage = "Home"
        Character.image = UIImage(named:characterColor + " Bro Idle 1")
        Background.image = UIImage(named:"Home Background")
    }
    @IBAction func GymButtonPressed(_ sender: Any) {
        backgroundImage = "Gym"
        Character.image = UIImage(named:characterColor + " Bro Lifting 1")
        Background.image = UIImage(named:"Gym Background")
    }
    
    @IBAction func FoodButtonPressed(_ sender: Any) {
        backgroundImage = "Kitchen"
        Character.image = UIImage(named:characterColor + " Bro Eating 1")
        Background.image = UIImage(named:"Kitchen Background")
    }
    @IBAction func LibraryButtonPressed(_ sender: Any) {
        backgroundImage = "Library"
        Character.image = UIImage(named:characterColor + " Bro Reading 1")
        Background.image = UIImage(named:"Library Background")
    }
}

