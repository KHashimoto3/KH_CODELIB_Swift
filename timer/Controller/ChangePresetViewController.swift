//
//  ChangePresetViewController.swift
//  Timer
//
//  Created by 橋本浩規 on 2022/04/09.
//

import UIKit

class ChangePresetViewController: UIViewController {
    
    //ナビゲーションバーのボタン
    var regist_time_button: UIBarButtonItem!
    
    //エラー表示用
        var alertController: UIAlertController!
    
    //表示文字列
    var disp_name_str: String!
    var set_time_str: String!
    
    //設定時間の表示
    @IBOutlet weak var SetTime: UILabel!
    
    //表示名
    @IBOutlet weak var disp_name: UITextField!
    //今の設定時間
    @IBOutlet weak var set_time: UILabel!
    
    //単位ボタン
    @IBOutlet weak var setHour_view: UIButton!
    @IBOutlet weak var setMin_view: UIButton!
    @IBOutlet weak var setSec_view: UIButton!
    
    //リセットボタン
    @IBOutlet weak var reset_view: UIButton!
    //スタートボタン
    
    
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
        disp_name.text=disp_name_str
        set_time.text=set_time_str
        
        //プリセット一覧のボタン
        regist_time_button=UIBarButtonItem(title: "登録", style: .done, target: self, action: #selector(regist_prest(_:)))
        //ナビゲーションバーの右側にボタンを追加
        self.navigationItem.rightBarButtonItem=regist_time_button
        
        
        //ボタンのデザイン（時間）
                setHour_view.layer.shadowColor = UIColor.black.cgColor //　影の色
                setHour_view.layer.shadowOpacity = 0.3  //影の濃さ
                setHour_view.layer.shadowRadius = 5.0 // 影のぼかし量
                setHour_view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0) // 影の方向
                
                //ボタンのデザイン（分）
                setMin_view.layer.shadowColor = UIColor.black.cgColor //　影の色
                setMin_view.layer.shadowOpacity = 0.3  //影の濃さ
                setMin_view.layer.shadowRadius = 5.0 // 影のぼかし量
                setMin_view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0) // 影の方向
                
                //ボタンのデザイン（分）
                setSec_view.layer.shadowColor = UIColor.black.cgColor //　影の色
                setSec_view.layer.shadowOpacity = 0.3  //影の濃さ
                setSec_view.layer.shadowRadius = 5.0 // 影のぼかし量
                setSec_view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0) // 影の方向
                
                //リセットボタンのデザイン
                reset_view.layer.shadowColor = UIColor.black.cgColor //　影の色
                reset_view.layer.shadowOpacity = 0.3  //影の濃さ
                reset_view.layer.shadowRadius = 5.0 // 影のぼかし量
                reset_view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0) // 影の方向
                
                //スタートボタンのデザイン
//                start_view.layer.shadowColor = UIColor.black.cgColor //　影の色
//                start_view.layer.shadowOpacity = 0.3  //影の濃さ
//                start_view.layer.shadowRadius = 5.0 // 影のぼかし量
//                start_view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0) // 影の方向
        
        
    }
    
    //登録完了画面の表示
    @objc func regist_prest(_ sender:UIBarButtonItem){
        //プリセットの登録処理
        
        let nextVC=storyboard?.instantiateViewController(withIdentifier: "go_to_complete")as! RegisteredPresetViewController
        nextVC.timer_disp_str=disp_name.text
        nextVC.set_timer_str=SetTime.text
        
        //ナビゲーションバーで遷移
        navigationController?.pushViewController(nextVC, animated: true)
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
    @IBAction func reset(_ sender: Any) {
        SetTime.text="時間を入力"
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
            SetTime.text="時間を入力"
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
