//
//  Sound.swift
//  Fajr Wake
//
//  Created by Ali Mir on 10/18/17.
//  Copyright © 2017 com.AliMir. All rights reserved.
//

import Foundation
import AVFoundation

struct SoundSetting {
    var ringtoneID: String
    var ringtoneExtension: String
    var isRepeated: Bool
}

class SoundPlayer {
    private var soundPlayer: AVAudioPlayer?
    private(set)var setting: SoundSetting
    
    init(setting: SoundSetting) {
        self.setting = setting
    }
    
    func play() {
        stop()
        let url = Bundle.main.url(forResource: setting.ringtoneID, withExtension: setting.ringtoneExtension)!
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = soundPlayer else { return }
            soundPlayer?.setVolume(1.0, fadeDuration: 3)
            if setting.isRepeated {
                player.numberOfLoops = -1
            }
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func stop() {
        if soundPlayer != nil {
            soundPlayer?.stop()
            soundPlayer = nil
        }
    }
    
    func setSetting(setting: SoundSetting) {
        stop()
        self.setting = setting
    }
}