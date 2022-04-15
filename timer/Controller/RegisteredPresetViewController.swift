//
//  RegisteredPresetViewController.swift
//  Timer
//
//  Created by 橋本浩規 on 2022/04/15.
//

import UIKit

class RegisteredPresetViewController: UIViewController {
    
    var complete_button:UIBarButtonItem!
    
    //遷移元からのデータ格納
    var timer_disp_str:String! = nil
    var set_timer_str:String!=nil
    
    @IBOutlet weak var timer_disp: UILabel!
    
    @IBOutlet weak var set_timer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //受け取ったデータを表示
        timer_disp.text=timer_disp_str
        set_timer.text=set_timer_str
        
        complete_button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(complete(_:)))
        //ナビゲーションバーの右側にボタンを追加
        self.navigationItem.rightBarButtonItem=complete_button
    }
    
    //完了ボタン
    @objc func complete(_ sender:UIBarButtonItem){
        //プリセット一覧画面へ戻る
            self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
    }
    
    // MARK: - Navigation

    

}
