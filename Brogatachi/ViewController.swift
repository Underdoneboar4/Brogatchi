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
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playSound(a: "song1")
        
        
        
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
        
    }
    @IBAction func GymButtonPressed(_ sender: Any) {
    }
    
    @IBAction func FoodButtonPressed(_ sender: Any) {
    }
    @IBAction func LibraryButtonPressed(_ sender: Any) {
    }
}

