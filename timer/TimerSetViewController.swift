//
//  TimerSetViewController.swift
//  Timer
//
//  Created by KH on 2021/08/27.
//

import UIKit

class TimerSetViewController: UIViewController {
    
    //エラー表示用
    var alertController: UIAlertController!
    
    //設定時間を表示する
    @IBOutlet weak var SetTime: UILabel!
    
    //プリセットの時間を表示する
    @IBOutlet weak var preset1_view: UIButton!
    @IBOutlet weak var preset2_view: UIButton!
    @IBOutlet weak var preset3_view: UIButton!
    
    //プリセットの設定を格納するPrestTimeのインスタンスを作成
    var preset=PresetTime()
    var preset_array=[PresetTime]()
    
    //時間設定用バッファ
    var timebuf=String()
    //リセット後フラグ
    var liset_flag=1
    
    //桁数フラグ
    var keta=0
    
    //値A（10の位）
    var numA=0
    //値B（１の位）
    var numB=0
    
    //設定された時間を入れる
    var hour=0
    //設定された分を入れる
    var min=0
    //設定された秒を入れる
    var sec=0
    
    //soundFileクラスを実体化
    var soundFile=SoundFile()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preset.time=60
        preset.disp_name="1分"
        preset_array.append(preset)
        
        preset.time=30
        preset.disp_name="30秒"
        preset_array.append(preset)
        
        preset.time=120
        preset.disp_name="2分"
        preset_array.append(preset)
        
        //present1_viewに、プリセットの１つ目を表示
        preset1_view.setTitle(preset_array[0].disp_name, for: .normal)
        preset1_view.titleLabel?.numberOfLines=0
        preset2_view.setTitle(preset_array[1].disp_name, for: .normal)
        preset2_view.titleLabel?.numberOfLines=0
        preset3_view.setTitle(preset_array[2].disp_name, for: .normal)
        preset3_view.titleLabel?.numberOfLines=0
        
    }
    
    //時間を設定する関数
    func setTime(num:Int){
        if liset_flag==1{
            SetTime.text=""
            liset_flag=0
        }
        
        //１桁目の時
        if keta==0{
            numA=num
            keta+=1
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+String(num)
            SetTime.text=timebuf
        //２桁目の時
        }else if keta==1{
            numB=num
            keta+=1
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+String(num)
            SetTime.text=timebuf
        //３桁目の時
        }else if keta==2{
            //エラーメッセージ
            alert()
            
        }
        //プッシュメロディーを流す
        soundFile.playSound(fileName: "push", extentionName: "mp3")
    }
    
    
    //時間設定ボタン（時間）
    @IBAction func setHour(_ sender: Any) {
        if keta==1{
            //１の位まで
            hour+=numA
            numA=0
            
        }else if keta==2{
            //１０の位まで
            hour+=numA*10
            numA=0
            hour+=numB
            numB=0
        }
        
        //オプションメロディーを流す
        soundFile.playSound(fileName: "option", extentionName: "mp3")
        
        //現在の時間設定を取得
        timebuf=SetTime.text!
        timebuf=timebuf+"時間"
        SetTime.text=timebuf
        //桁数をリセット
        keta=0
    }
    //時間設定ボタン（分）
    @IBAction func setMin(_ sender: Any) {
        if keta==1{
            //１の位まで
            min+=numA
            numA=0
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+"分"
            SetTime.text=timebuf
            //桁数をリセット
            keta=0
            
        }else if keta==2{
            //１０の位まで
            min+=numA*10
            numA=0
            min+=numB
            numB=0
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+"分"
            SetTime.text=timebuf
            //桁数をリセット
            keta=0
        }
        
        if min>59{
            //エラーメッセージ
           alert()
            
        }
        
        //オプションメロディーを流す
        soundFile.playSound(fileName: "option", extentionName: "mp3")
        
       
    }
    //時間設定ボタン（秒）
    @IBAction func setSec(_ sender: Any) {
        if keta==1{
            //１の位まで
            sec+=numA
            numA=0
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+"秒"
            SetTime.text=timebuf
            //桁数をリセット
            keta=0
            
        }else if keta==2{
            //１０の位まで
            sec+=numA*10
            numA=0
            sec+=numB
            numB=0
            //現在の時間設定を取得
            timebuf=SetTime.text!
            timebuf=timebuf+"秒"
            SetTime.text=timebuf
            //桁数をリセット
            keta=0
        }
        
        
        if sec>59{
            //エラーメッセージ
            alert()
            
        }
        
        //オプションメロディーを流す
        soundFile.playSound(fileName: "option", extentionName: "mp3")
    }
    
    //各数字ボタン
    @IBAction func set1(_ sender: Any) {
        setTime(num: 1)
    }
    @IBAction func set2(_ sender: Any) {
        setTime(num: 2)
    }
    
    @IBAction func set3(_ sender: Any) {
        setTime(num: 3)
    }
    
    @IBAction func set4(_ sender: Any) {
        setTime(num: 4)
    }
    
    @IBAction func set5(_ sender: Any) {
        setTime(num: 5)
    }
    
    @IBAction func set6(_ sender: Any) {
        setTime(num: 6)
    }
    
    
    @IBAction func set7(_ sender: Any) {
        setTime(num: 7)
    }
    
    @IBAction func set8(_ sender: Any) {
        setTime(num: 8)
    }
    
    @IBAction func set9(_ sender: Any) {
        setTime(num: 9)
    }
    
    @IBAction func set0(_ sender: Any) {
        setTime(num: 0)
    }
    
    //リセットボタン
    @IBAction func clear(_ sender: Any) {
        SetTime.text="時間を決める"
        //全ての値をリセット
        liset_flag=1
        keta=0
        numA=0
        numB=0
        hour=0
        min=0
        sec=0
        
        //リセットメロディーを流す
        soundFile.playSound(fileName: "reset", extentionName: "mp3")
    }
    
    
    //スタートボタン
    @IBAction func start(_ sender: Any) {
        //いずれかの値が入っていたら
        let ret=check_zero(num1: hour, num2: min, num3: sec)
        if ret==true{
            //カウントダウン画面に移る
            print("現在入っている時間を表示します（設定画面）: "+String(hour)+"時間"+String(min)+"分"+String(sec)+"秒です。")
            
            //スタートメロディーを流す
            soundFile.playSound(fileName: "start", extentionName: "mp3")
            
            self.performSegue(withIdentifier: "next", sender: nil)
            
        }else{
            //いずれも値が入っていなかったら
            //エラーを出す
            alertController = UIAlertController(title:"エラー",
                                           message: "時間を決めてから押してください！！",
                                           preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil))
            present(alertController, animated: true)
            
            //すべてをリセット
            SetTime.text="時間を決める"
            //全ての値をリセット
            liset_flag=1
            keta=0
            numA=0
            numB=0
            hour=0
            min=0
            sec=0
            
            //リセットメロディーを流す
            soundFile.playSound(fileName: "reset", extentionName: "mp3")
            
        }
        
        
    }
    
    //segue（next）遷移時に渡す値を設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="next"{
            let nextVC=segue.destination as! TimerRunningViewController
            nextVC.time_hour=hour
            nextVC.time_min=min
            nextVC.time_sec=sec
        }
    }
    
    //プリセットボタンが押された時の動作
    //プリセット1
    
    @IBAction func preset1(_ sender: Any) {
        let sec_all=preset_array[0].time
        hour=sec_all/3600
        min=(sec_all-(3600*hour))/60
        sec=(sec_all-(3600*hour))-(60*min)
        
        //カウントダウン画面に移る
        print("現在入っている時間を表示します（設定画面）: "+String(hour)+"時間"+String(min)+"分"+String(sec)+"秒です。")
        
        //スタートメロディーを流す
        soundFile.playSound(fileName: "start", extentionName: "mp3")
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    //プリセット2
    
    @IBAction func preset2(_ sender: Any) {
        let sec_all=preset_array[1].time
        hour=sec_all/3600
        min=(sec_all-(3600*hour))/60
        sec=(sec_all-(3600*hour))-(60*min)
        
        //カウントダウン画面に移る
        print("現在入っている時間を表示します（設定画面）: "+String(hour)+"時間"+String(min)+"分"+String(sec)+"秒です。")
        
        //スタートメロディーを流す
        soundFile.playSound(fileName: "start", extentionName: "mp3")
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    //プリセット3
    
    @IBAction func preset3(_ sender: Any) {
        let sec_all=preset_array[2].time
        hour=sec_all/3600
        min=(sec_all-(3600*hour))/60
        sec=(sec_all-(3600*hour))-(60*min)
        
        //カウントダウン画面に移る
        print("現在入っている時間を表示します（設定画面）: "+String(hour)+"時間"+String(min)+"分"+String(sec)+"秒です。")
        
        //スタートメロディーを流す
        soundFile.playSound(fileName: "start", extentionName: "mp3")
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    
    
    //時間がどれか入っているかどうかを判定
    func check_zero(num1:Int,num2:Int,num3:Int)->Bool{
        if num1 != 0{
            return true
        }
        if num2 != 0{
            return true
        }
        if num3 != 0{
            return true
        }
        return false
    }
    
    //エラーメッセージ表示
    func alert() {
        alertController = UIAlertController(title:"エラー",
                                       message: "正しくない数字です",
                                       preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        present(alertController, animated: true)
        
        //すべてをリセット
        SetTime.text="時間を決める"
        //全ての値をリセット
        liset_flag=1
        keta=0
        numA=0
        numB=0
        hour=0
        min=0
        sec=0
        
        //リセットメロディーを流す
        soundFile.playSound(fileName: "reset", extentionName: "mp3")
        
    }

}
