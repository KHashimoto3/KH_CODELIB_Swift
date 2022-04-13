//
//  ChangePresetViewController.swift
//  Timer
//
//  Created by 橋本浩規 on 2022/04/09.
//

import UIKit

class ChangePresetViewController: UIViewController {
    
    var disp_name_str: String!
    var set_time_str: String!
    
    @IBOutlet weak var disp_name: UITextField!
    
    @IBOutlet weak var set_time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disp_name.text=disp_name_str
        set_time.text=set_time_str
        
    }
    


}
