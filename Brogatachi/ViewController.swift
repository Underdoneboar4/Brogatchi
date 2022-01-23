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
    
    @IBOutlet weak var FoodButton: UIButton!
    @IBOutlet weak var BookButton: UIButton!
    @IBOutlet weak var GymButton: UIButton!
    @IBOutlet weak var HomeButton: UIButton!
    
    
    var timeShifter = 0
    var tapShifter = 1
    
    var gymStat = 0.0
    var bookStat = 0.0
    var foodStat = 0.0
    var restStat = 0.0
    
    var backgroundPlayer: AVAudioPlayer?
    var effectPlayer: AVAudioPlayer?
    var timer = Timer()
    var tapCount = 0
    var isEgging = false
    var canChangeLocation = false
    
    var characterColor = "Red"
    //characterColor MUST become RedEgg
    var backgroundImage = "Home"
    
    override func viewDidLoad() {
        FoodButton.alpha = 0.4
        BookButton.alpha = 0.4
        GymButton.alpha = 0.4
        HomeButton.alpha = 0.4
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //playSound(file: "song1")
        playBackgroundMusic(filenamed: "song1")

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
        FoodButton.alpha = 1
        BookButton.alpha = 1
        GymButton.alpha = 1
        HomeButton.alpha = 1
        isEgging = false
        canChangeLocation = true
        HatchTipLabel.isHidden = true
        Character.image = UIImage(named:characterColor + " Bro Idle 1")
        backgroundImage = "Home"
        Background.image = UIImage(named:"Home Background")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        //player?.stop()
        backgroundPlayer?.stop()
        //playSound(file: "mainLoop")
        playBackgroundMusic(filenamed: "mainLoop")
        
    }
    
    
    @objc func timerAction(){
        
        
        if(backgroundImage == "Home"){
            if(timeShifter == 0){
                timeShifter = 1
                Character.image = UIImage(named:characterColor + " Bro Idle 2")
            } else{
                timeShifter = 0
                Character.image = UIImage(named:characterColor + " Bro Idle 1")
            }
            
            restStat += 1
            gymStat -= 0.1
            foodStat -= 0.1
            bookStat -= 0.1
            
            if(restStat > 100){
                restStat = 100
            }
            
        }
    }

    func tapShift(){
        if(tapShifter < 3){
            tapShifter += 1
        } else{
            tapShifter = 1
        }
        
        if(backgroundImage == "Home"){
            //PETTING
            Character.image = UIImage(named:characterColor + " Bro Pet")
            restStat += 0.1
            
        } else if(backgroundImage == "Gym"){
            gymStat += 2
            foodStat -= 0.4
            bookStat -= 0.75
            restStat -= 0.25
            if(gymStat > 100){
                gymStat = 100
            }
            Character.image = UIImage(named:characterColor + " Bro Lifting " + String(tapShifter))
            
        } else if(backgroundImage == "Kitchen"){
            gymStat -= 0.75
            foodStat += 1.5
            bookStat -= 0.75
            restStat -= 0.25
            if(foodStat > 100){
                foodStat = 100
            }
            Character.image = UIImage(named:characterColor + " Bro Eating " + String(tapShifter))
            
        } else if (backgroundImage == "Library"){
            gymStat -= 0.75
            foodStat -= 0.4
            bookStat += 3
            restStat -= 0.25
            if(bookStat > 100){
                bookStat = 100
            }
            Character.image = UIImage(named:characterColor + " Bro Reading " + String(tapShifter))
            
        }
    }
    func playBackgroundMusic(filenamed: String){

            let url = Bundle.main.url(forResource: filenamed, withExtension: ".wav")
            guard let newUrl = url else{

                print ("Could not find file called (filenamed)")
                return
            }
            do {

                backgroundPlayer = try AVAudioPlayer(contentsOf: newUrl)
                backgroundPlayer?.numberOfLoops = -1
                backgroundPlayer?.prepareToPlay()
                backgroundPlayer?.play()
            }
            catch let error as NSError {
                print (error.description)

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
        if(canChangeLocation){
            backgroundImage = "Home"
            Character.image = UIImage(named:characterColor + " Bro Idle 1")
            Background.image = UIImage(named:"Home Background")
        }
    }
    @IBAction func GymButtonPressed(_ sender: Any) {
        if(canChangeLocation){
            backgroundImage = "Gym"
            Character.image = UIImage(named:characterColor + " Bro Lifting 1")
            Background.image = UIImage(named:"Gym Background")
        }
    }
    
    @IBAction func FoodButtonPressed(_ sender: Any) {
        if(canChangeLocation){
            backgroundImage = "Kitchen"
            Character.image = UIImage(named:characterColor + " Bro Eating 1")
            Background.image = UIImage(named:"Kitchen Background")
        }

    }
    @IBAction func LibraryButtonPressed(_ sender: Any) {
        if(canChangeLocation){
            backgroundImage = "Library"
            Character.image = UIImage(named:characterColor + " Bro Reading 1")
            Background.image = UIImage(named:"Library Background")
        }
    }
}

