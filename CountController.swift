//
//  CountController.swift
//  Count Quiz
//
//  Created by 澤畑和幸 on 2018/08/29.
//  Copyright © 2018年 Kzu. All rights reserved.
//

import UIKit

class CountController: UIViewController {

    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    var count = 3
    var count2 = 0.00
    var timer: Timer?
    var timer2: Timer?
    let settingKey = "settingKey"
    let settings = UserDefaults.standard
    var rank: String = "Bランク"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: 0.7,
                                          target: self,
                                          selector: #selector(CountController.countDown),
                                          userInfo: nil,
                                          repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSettingCount() -> Int {
        let settingSecond = settings.integer(forKey: settingKey)
        return settingSecond
    }
    
    @objc func countDown(){
        if count > 0 {
            let countText = String(count)
            startLabel.text = countText
            count -= 1
        } else if count == 0 {
            startLabel.text = "START!"
            count -= 1
        } else {
            startLabel.text = ""
            self.timer?.invalidate()
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.01,
                                               target: self,
                                               selector: #selector(CountController.countUp),
                                               userInfo: nil,
                                               repeats: true)
        }
    }
    
    @objc func countUp(){
        if count2 < 3.00 {
            let countText2 = String(count2)
            countLabel.text = countText2
            count2 += 0.01
        } else {
            let time = getSettingCount()
            countLabel.text = "\(time)でタップ！"
            count2 += 0.01
        }
        
    }
    
    @IBAction func stopButton(_ sender: Any) {
        let result = count2
        self.timer2?.invalidate()
        let time = getSettingCount()
        let doubleTime = Double(time)
        let decitionTime = doubleTime - result
        if decitionTime > -1 && decitionTime < 1 {
            rank = "Sランク"
        } else if decitionTime > -5 && decitionTime < 5 {
            rank = "Aランク"
        }
        let alertController = UIAlertController(title:"\(rank)",
                                                message:"タイム：\(result)秒",
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK",style: .default, handler: {(action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            })
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion:nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
