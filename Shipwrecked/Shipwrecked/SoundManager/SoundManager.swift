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
        case IslandTheme
        case CaveSoundtrack
        case CaveBoss
        case JungleSoundtrack
        case JungleBoss
        case VolcanoSoundtrack
        case VolcanoBoss
    }
    
    func playMusic(sound: MusicOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.play()
            backgroundMusic?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Combat
    
    var combatSounds: AVAudioPlayer?
    
    enum CombatOption: String {
        case gunfire
        case hit
        case swoosh
        case swoosh1
        case swoosh2
        case swordThud
        case multipleSwords
        case chop
        case knife
        case slice
        case slice1
        case punch
        case punch1
        
    }
    
    func playCombatmp3(sound: CombatOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            combatSounds = try AVAudioPlayer(contentsOf: url)
            combatSounds?.play()
            combatSounds?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playCombat(sound: CombatOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            combatSounds = try AVAudioPlayer(contentsOf: url)
            combatSounds?.play()
            combatSounds?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Tiki Guys sounds
    
    var tikiGuys: AVAudioPlayer?
    
    enum TikiOption: String {
        case tikiHit = "bonk"
        case tikiBonk = "bonk2"
    }
    
    func playTikiSoundmp3(sound: TikiOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            tikiGuys = try AVAudioPlayer(contentsOf: url)
            tikiGuys?.play()
            tikiGuys?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playTikiSound(sound: TikiOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            tikiGuys = try AVAudioPlayer(contentsOf: url)
            tikiGuys?.play()
            tikiGuys?.volume = volume
        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    
    // MARK: - Sound Effects
    
    var soundEffecets: AVAudioPlayer?
    
    enum SoundEffect: String {
        case multipleBonks
        case eat
        case eating1
        case eating
        case burp
        case fail
        case human
        case insane
        case zap
        case collectItem
        case clang
        case horse
        case start
    }
    
    func playSoundEffectmp3(sound: SoundEffect, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            soundEffecets = try AVAudioPlayer(contentsOf: url)
            soundEffecets?.play()
            soundEffecets?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playSoundEffect(sound: SoundEffect, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            soundEffecets = try AVAudioPlayer(contentsOf: url)
            soundEffecets?.play()
            soundEffecets?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    // MARK: - Walking Sound
    
    var walkSound: AVAudioPlayer?
    
    enum WalkSoundOption: String {
        case walk = "walk"
        case walkOnLeaves = "walkOnLeaves"
    }
    
    func playSoundEffect(sound: WalkSoundOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            walkSound = try AVAudioPlayer(contentsOf: url)
            walkSound?.play()
            walkSound?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
    
    func playSoundEffectmp3(sound: WalkSoundOption, volume: Float) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            walkSound = try AVAudioPlayer(contentsOf: url)
            walkSound?.play()
            walkSound?.volume = volume
        } catch let error { print("Error playing sound \(error.localizedDescription)") }
    }
}
