//
//  PresetListViewController.swift
//  Timer
//
//  Created by 橋本浩規 on 2022/03/22.
//

import UIKit

class PresetListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    //TableView
    @IBOutlet weak var preset_list_table: UITableView!
    
    
    //TimerSetViewから受け取るプリセット情報
    var preset_array=[PresetTime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preset_list_table.delegate=self
        preset_list_table.dataSource=self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preset_array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=preset_list_table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let preset_name=cell.contentView.viewWithTag(1) as! UILabel
        let preset_time=cell.contentView.viewWithTag(2) as! UILabel
        
        //時間表示のための変数
        let h=preset_array[indexPath.row].time/3600
        let m=(preset_array[indexPath.row].time-(3600*h))/60
        let s=(preset_array[indexPath.row].time-(3600*h))-(60*m)
        
        
        preset_name.text=preset_array[indexPath.row].disp_name
        preset_time.text=String(format: "%02d",h)+"時間"+String(format: "%02d",m)+"分"+String(format: "%02d",s)+"秒"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    //セルがクリックされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC=storyboard?.instantiateViewController(withIdentifier: "change_preset")as! ChangePresetViewController
        
        print(preset_array[indexPath.row].disp_name)
        nextVC.disp_name_str=preset_array[indexPath.row].disp_name
        
        //時間表示のための変数
        let h=preset_array[indexPath.row].time/3600
        let m=(preset_array[indexPath.row].time-(3600*h))/60
        let s=(preset_array[indexPath.row].time-(3600*h))-(60*m)
        
        nextVC.set_time_str=String(format: "%02d",h)+"時間"+String(format: "%02d",m)+"分"+String(format: "%02d",s)+"秒"
        
        //ナビゲーションバーで遷移
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    

}
