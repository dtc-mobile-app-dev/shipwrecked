//
//  SoundManager.swift
//  Shipwrecked
//
//  Created by Asher McConnell on 8/14/23.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static let instance = SoundManager()
    
    // MARK: - Music
    
    var backgroundMusic: AVAudioPlayer?
    
    enum MusicOption: String {
        case islandTheme
        case caveTheme
        case caveBoss
        case jungleTheme
        case jungleBoss
        case volcanoTheme
        case volcanoBoss
    }
    
    func playMusic(sound: MusicOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.play()
            backgroundMusic?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Combat
    
    var combatSounds: AVAudioPlayer?
    
    enum CombatOption: String {
        case gunfire = "gun"
        case hit = "bonk1"
        case useSword = "swoosh"
        case swoosh = "swoosh1"
        case chop = "chop"
        case knife = "knife"
        case slice = "slice"
        case slice1 = "slice1"
        case punch = "punch"
        case punch1 = "punch1"
    }
    
    func playCombatmp3(sound: CombatOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            combatSounds = try AVAudioPlayer(contentsOf: url)
            combatSounds?.play()
            combatSounds?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playCombat(sound: CombatOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            combatSounds = try AVAudioPlayer(contentsOf: url)
            combatSounds?.play()
            combatSounds?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Tiki Guys sounds
    
    var tikiGuys: AVAudioPlayer?
    
    enum TikiOption: String {
        case tikiHit = "bonk"
    }
    
    func playTikiSoundmp3(sound: TikiOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            tikiGuys = try AVAudioPlayer(contentsOf: url)
            tikiGuys?.play()
            tikiGuys?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playTikiSound(sound: TikiOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            tikiGuys = try AVAudioPlayer(contentsOf: url)
            tikiGuys?.play()
            tikiGuys?.volume = 1.0
        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    
    // MARK: - Sound Effects
    
    var soundEffecets: AVAudioPlayer?
    
    enum SoundEffect: String {
        case bonk = "multipleBonks"
        case eat = "eat"
        case eating = "eating"
        case burp = "burp"
        case lose = "fail"
        case win
        case zap = "zap"
        case collectItem = "collectItem"
    }
    
    func playSoundEffectmp3(sound: SoundEffect) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            soundEffecets = try AVAudioPlayer(contentsOf: url)
            soundEffecets?.play()
            soundEffecets?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playSoundEffect(sound: SoundEffect) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            soundEffecets = try AVAudioPlayer(contentsOf: url)
            soundEffecets?.play()
            soundEffecets?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Walking Sound
    
    var walkSound: AVAudioPlayer?
    
    enum WalkSoundOption: String {
        case walk = "walk"
        case walkOnLeaves = "leavesCrunching"
        //        case islandWalk
        //        case caveWalk
        //        case jungleWalk
        //        case volcanoWalk
    }
    
    func playSoundEffect(sound: WalkSoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            walkSound = try AVAudioPlayer(contentsOf: url)
            walkSound?.play()
            walkSound?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playSoundEffectmp3(sound: WalkSoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            walkSound = try AVAudioPlayer(contentsOf: url)
            walkSound?.play()
            walkSound?.volume = 1.0
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
}
