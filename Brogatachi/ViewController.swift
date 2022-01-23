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
    var timeShifter = 0
    
    var player: AVAudioPlayer?
    var timer = Timer()
    
    var characterColor = "Red"
    var backgroundImage = "Home"
    
    @IBOutlet weak var Character: UIImageView!
    @IBOutlet weak var Background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        playSound(a: "song1")
        
        
        
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

    func playSound(a: String) {
        guard let url = Bundle.main.url(forResource: a, withExtension: "wav") else { return }

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

