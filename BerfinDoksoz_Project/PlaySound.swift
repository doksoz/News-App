//
//  PlaySound.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 24.12.2022.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    
    if let player = audioPlayer, player.isPlaying{
        audioPlayer?.stop()
    }else{
        
        if let path = Bundle.main.path(forResource: sound, ofType: type){
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }catch{
                print("Error with sound")
            }
        }
    }
}
