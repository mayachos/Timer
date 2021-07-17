//
//  ViewController.swift
//  Timer
//
//  Created by maya on 2021/07/17.
//

import UIKit

class ViewController: UIViewController, backgroundTimerDelegate {
    
    var timerIsBackground: Bool = false
    
    var judge: Bool = false
    @IBOutlet var label: UILabel!
    
    
    //【変更】Int型からFloat型に変更
    var count: Float = 0.00
    
    var timer: Timer = Timer()
    var saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc func up() {
        
        //【変更】countを0.01足す
        count = count + 0.01
        
        //ラベルに小数点以下2桁まで表示
        label.text = String(format: "%.2f", count)
        }
        
        @IBAction func start() {
            
            if !timer.isValid {
                
                //タイマーが動作してなかったら動かす
                //【変更】timeIntervalを0.01に変更
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
                judge = true

            }
        }
        
       
        
        @IBAction func stop() {
            if timer.isValid {
                //タイマーが動作していたら停止する
                timer.invalidate()
                judge = false
            }
        }
        
        // ViewController.swift
        @IBAction func nextButtonTouchUp(_ sender: UIButton) {
            let nextVC = storyboard?.instantiateViewController(identifier: "HomeView")

            nextVC?.modalPresentationStyle = .fullScreen // ★この行追加
            self.present(nextVC!, animated: true, completion: nil)
        }
       
        @IBAction func reset() {
            if timer.isValid {
                timer.invalidate()
            }
            count = 0
            label.text = String(format: "%.2f", count)
        }
        func checkBackground() {
            if judge == true {
                
                //バックグラウンドへの移行を確認
                //【変更】条件式をlet _ = timerからtimer.isValidへ変更
                if timer.isValid {
                    timerIsBackground = true
                }
            }
        }
        
    //【変更】elapsedTimeの型をIntからFloatに変更
        func setCurrentTimer(_ elapsedTime:Float) {
            if judge == true {
                //残り時間から引数(バックグラウンドでの経過時間)を足す
                count += elapsedTime
                label.text = "\(count)"
                
                //再びタイマーを起動
                //【変更】timeIntervalを0.01に変更
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
            }
        }
        
        func deleteTimer() {
            if judge == true {
                
                //起動中のタイマーを破棄
                //【変更】条件式をlet _ = timerからtimer.isValidへ変更
                if timer.isValid {
                    timer.invalidate()
                }
            }
        }
        
        

        

        @IBAction func saveMemo() {
            //UserDefaultsに書き込み
            saveData.set(label.text, forKey: "time")
        }

}

