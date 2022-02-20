//
//  SoundFile.swift
//  Timer
//
//  Created by 橋本浩規 on 2021/09/14.
//

import Foundation

//音を鳴らすキット
import AVFoundation

class SoundFile{
    var player:AVAudioPlayer?
    
    //音を鳴らす機能
    func playSound(fileName:String,extentionName:String){
        //再生する
        let soundURL=Bundle.main.url(forResource: fileName, withExtension: extentionName)
        
        do {
            //効果音を鳴らす
            player=try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("エラーです！")
        }
    }
    
}

