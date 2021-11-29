//
//  TimerRunningViewController.swift
//  Timer
//
//  Created by KH on 2021/08/28.
//

import UIKit

class TimerRunningViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nokori_time_label: UILabel!
    
    //タイマーの使用
    var timer:Timer!
    
    //設定画面からもらう時間情報を入れるための変数
    var time_hour=Int()
    var time_min=Int()
    var time_sec=Int()
    
    var h=Int()
    var m=Int()
    var s=Int()
    //残り時間（秒数）を保持する
    var nokori_sec=Int()
    
    //フィードバックを表示する
    @IBOutlet weak var feedback: UILabel!
    
    
    //もう１分ボタン
    @IBOutlet weak var one_min_button: UIButton!
    //止めるボタン
    @IBOutlet weak var stop_button: UIButton!
    //続けるボタン
    @IBOutlet weak var continue_button: UIButton!
    //もう１度ボタン
    @IBOutlet weak var replay_button: UIButton!
    //もどるボタン
    @IBOutlet weak var back_button: UIButton!
    
    
    //soundFileクラスを実体化
    var soundFile=SoundFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text="設定時間: "+String(time_hour)+"時間"+String(time_min)+"分"+String(time_sec)+"秒"
        
        //値を設定
        h=time_hour
        m=time_min
        s=time_sec
        //秒数を計算
        nokori_sec=(time_hour*3600)+(time_min*60)+time_sec
        
        //残り時間を表示
        nokori_time_label.text=String(h)+":"+String(m)+":"+String(s)
        
        
        //無効なボタンを設定する
        one_min_button.isHidden=true
        continue_button.isHidden=true
        replay_button.isHidden=true
        back_button.isHidden=true
        
        //タイマーの開始
        self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerRunningViewController.update), userInfo: nil, repeats: true)
        
    }
    
    //タイマーの秒ごとの繰り返し処理
    @objc func update(){
        if nokori_sec==1{
            endtimer()
        }
        //表示内容を更新
        if nokori_sec<60{   //１分未満
            s=s-1
        }else if nokori_sec<3600{   //１時間未満
            if s==0{
                m=m-1
                s=59
            }else{
                s=s-1
            }
        }else{      //１時間以上
            if s==0{
                if m==0{
                    h=h-1
                    m=59
                    s=59
                }else{
                    m=m-1
                    s=59
                }
            }else{
                s=s-1
            }
        }
        nokori_sec=nokori_sec-1
        //残り時間を表示
        nokori_time_label.text=String(h)+":"+String(m)+":"+String(s)
        
    }

    //設定時間になったら
    func endtimer(){
        //終了を表示
        nokori_time_label.text="時間になりました！"
        print("終了しました")
        feedback.text="終了しました。"
        //タイマーを破棄
        self.timer?.invalidate()
        //終了メロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
        
        //無効なボタンを設定する
        one_min_button.isHidden=false
        stop_button.isHidden=true
        replay_button.isHidden=false
        back_button.isHidden=false
        
    }
    
    //もう１分ボタン
    @IBAction func one_min(_ sender: Any) {
        //値を設定
        h=0
        m=1
        s=0
        //秒数を計算（1分）
        nokori_sec=1*60
                
        //残り時間を表示
        nokori_time_label.text=String(h)+":"+String(m)+":"+String(s)
                
        feedback.text="もう１分追加しました。"
                
        //タイマーの開始
        self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerRunningViewController.update), userInfo: nil, repeats: true)
                
        //もう一度メロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
                
        //無効なボタンを設定する
        one_min_button.isHidden=true
        stop_button.isHidden=false
        continue_button.isHidden=true
        replay_button.isHidden=true
        back_button.isHidden=true
    }
    
    
    //止めるボタン
    @IBAction func stop(_ sender: Any) {
        feedback.text="タイマーを止めました。"
        //タイマーを破棄
        self.timer?.invalidate()
        //停止メロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
        //無効なボタンを設定する
        one_min_button.isHidden=true
        stop_button.isHidden=true
        continue_button.isHidden=false
        replay_button.isHidden=false
        back_button.isHidden=false
    }
    
    //続けるボタン
    @IBAction func `continue`(_ sender: Any) {
        feedback.text="続きから始めました。"
        //タイマーの開始
        self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerRunningViewController.update), userInfo: nil, repeats: true)
        //続けるメロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
        
        //無効なボタンを設定
        one_min_button.isHidden=true
        stop_button.isHidden=false
        continue_button.isHidden=true
        replay_button.isHidden=true
        back_button.isHidden=true
    }
    
    //もう１度ボラン
    @IBAction func replay(_ sender: Any) {
        //値を設定
        h=time_hour
        m=time_min
        s=time_sec
        //秒数を計算
        nokori_sec=(time_hour*3600)+(time_min*60)+time_sec
        
        //残り時間を表示
        nokori_time_label.text=String(h)+":"+String(m)+":"+String(s)
        
        feedback.text="設定時間でもう一度やります。"
        
        //タイマーの開始
        self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerRunningViewController.update), userInfo: nil, repeats: true)
        
        //もう一度メロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
        
        //無効なボタンを設定する
        one_min_button.isHidden=true
        stop_button.isHidden=false
        continue_button.isHidden=true
        replay_button.isHidden=true
        back_button.isHidden=true
    }
    
    //もどるボタン
    @IBAction func reset(_ sender: Any) {
        //リセットメロディーを流す
        soundFile.playSound(fileName: "ファイル名", extentionName: "mp3")
        self.dismiss(animated: true, completion: nil)
    }

}
