//
//  AnimationViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/31.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit
import AVFoundation

class AnimationViewController: UIViewController {
    
    var projectLabel: String = ""

    let userDefaults = UserDefaults.standard
//    var timer:Timer?
    var endpage = 1//保存されているページの数
    var totalTag = 1//全ての人数
    
//音楽再生のメソッド-----------------------------------------------------------
    var player:AVAudioPlayer? //音声を制御するための変数
    //var soundManager = SEManager()

        //BGM再生メソッド
    func play(soundName: String){
        //String型の引数からサウンドファイルを読み込む
        let soundPath = Bundle.main.path(forResource: soundName, ofType: "m4a")
        //読み込んだファイルにパスをつける
        let url:NSURL? = NSURL.fileURL(withPath: soundPath!) as NSURL
        
        //playerに読み込んだmp3ファイルへパスを設定する
        do {
            player = try AVAudioPlayer(contentsOf:url! as URL)
        }catch{
            print("error")
        }
        player?.numberOfLoops = -1 //BGMを無限にループさせる
        player?.prepareToPlay() //音声を即時再生させる
        player?.play() //音を再生する
    }
//-----------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        endpage = userDefaults.object(forKey: "\(projectLabel)_endpage") as! Int
        totalTag = userDefaults.object(forKey: "\(projectLabel)_totalTag") as! Int
        //最初の立ち位置を読み込み-------------------------
        var cordinate = userDefaults.object(forKey: "\(projectLabel)_\(1)") as! [[CGFloat]]
        var tag = cordinate.count
        while tag < totalTag {
            if tag % 2 == 0 {
                cordinate.append([0.0,0.0 - self.view.frame.width * 0.5 ,self.view.frame.height/2])
            }else{
                cordinate.append([0.0,self.view.frame.width * 1.5,self.view.frame.height/2])
            }
            tag = tag + 1
        }
        for i in 1..<(totalTag){
            let imageLabel = UILabel()
            labelSet(imageLabel,i,cordinate[i][1],cordinate[i][2])
            imageLabel.tag = i
            self.view.addSubview(imageLabel)
        }
        //--------------------------------------------
        
        //playメソッドの呼び出し。引数はファイル名
//        play(soundName: "06 JENIFER NITTO feat.TOFFY G_EVERYO")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //readData1() //UIView.animateKeyframes
        //readData2() //UIView.animate
        //readData3() //CABasicAnimation
        readData4() //CAKeyframeAnimation
        //readData5() //番外編CASpringAnimation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editField(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//データ読み込み
//=========================================================
//UIView
//=========================================================
//UIView.animateKeyframesメソッド ver.
    @objc func readData1(){
        UIView.animateKeyframes(withDuration: 1.0*Double(self.endpage-1), delay: 0.0,animations: {
            for j in 2...(self.endpage){
                var cordinate = self.userDefaults.object(forKey: "\(self.projectLabel)_\(j)") as! [[CGFloat]]
                var tag = cordinate.count
                while tag < self.totalTag {
                    if tag % 2 == 0 {
                        cordinate.append([0.0,0.0 - self.view.frame.width/2 ,self.view.frame.height/2])
                    }else{
                        cordinate.append([0.0,self.view.frame.width * 3,self.view.frame.height/2])
                    }
                    tag = tag + 1
                }
                for i in 1..<(self.totalTag){
                    if let imgL = self.view.viewWithTag(i){
                        UIView.addKeyframe(withRelativeStartTime: Double(j-2)/Double(self.endpage-1),
                                           relativeDuration: 1.0/Double(self.endpage-1),
                                           animations: {
                                            imgL.frame = CGRect(x: cordinate[i][1],
                                                                y: cordinate[i][2],
                                                                width: imgL.frame.width,
                                                                height: imgL.frame.height)
                                            }
                        )
                    }
                }
            }
        } , completion: nil)
    }
//==========================================================
//UIView.animateメソッド
    @objc func readData2(){
        for j in 2...(self.endpage){
            var cordinate = self.userDefaults.object(forKey: "\(projectLabel)_\(j)") as! [[CGFloat]]
            var tag = cordinate.count
            while tag < self.totalTag {
                if tag % 2 == 0 {
                    cordinate.append([0.0,0.0 - self.view.frame.width * 0.5 ,self.view.frame.height/2])
                }else{
                    cordinate.append([0.0,self.view.frame.width * 1.5,self.view.frame.height/2])
                }
                tag = tag + 1
            }
            for i in 1...(self.totalTag){
                if self.view.viewWithTag(i) != nil{
                    let imgL = self.view.viewWithTag(i)
                    UIView.animate(withDuration: 1.0,
                                   delay: Double(j-2),
                                   animations: {
                                        imgL?.frame = CGRect(x:cordinate[i][1],
                                                             y:cordinate[i][2],
                                                             width:(imgL?.frame.width)!,
                                                             height:(imgL?.frame.height)!)
                                    }, completion: nil)
                }
            }
        }

    }
//===============================================================
//CoreAnimation
//===============================================================
//CABasicAnimation  ver.
    @objc func readData3(){
        let animationgroup = CAAnimationGroup()
        //let tag = 4
        for i in 1...(totalTag){
            animationgroup.animations = []
            if self.view.viewWithTag(i) != nil{
                let imgL = self.view.viewWithTag(i)
                for j in 2...(endpage){
                    var cordinate = self.userDefaults.object(forKey: "\(projectLabel)_\(j)") as! [[CGFloat]]
                    var tag = cordinate.count
                    while tag < self.totalTag {
                        if tag % 2 == 0 {
                            cordinate.append([0.0,0.0 - self.view.frame.width * 0.5 ,self.view.frame.height/2])
                        }else{
                            cordinate.append([0.0,self.view.frame.width * 1.5,self.view.frame.height/2])
                        }
                        tag = tag + 1
                    }

                    let animation = CABasicAnimation(keyPath: "position")
                    // 到達位置
                    let xrange = (imgL?.frame.width)!/2.0
                    let yrange = (imgL?.frame.height)!/2.0
                    animation.toValue = [xrange + cordinate[i][1],yrange + cordinate[i][2]]
                    // アニメーション時間
                    animation.duration = 1.0
                    animation.beginTime = Double(j-2)
                    animation.isRemovedOnCompletion = false
                    animation.fillMode = kCAFillModeForwards
                    //animationgroup.animations = [animation]
                    animationgroup.animations?.append(animation)
                }
                animationgroup.duration = Double(endpage - 1)
                // アニメーションが終了した時の状態を維持する
                animationgroup.isRemovedOnCompletion = false
                animationgroup.fillMode = kCAFillModeForwards
                // アニメーションが終了したらanimationDidStopを呼び出す
                animationgroup.delegate = self as? CAAnimationDelegate
                // アニメーションの追加
                imgL?.layer.add(animationgroup, forKey: nil)
            }
        }
    }
//===============================================================
//CASpringAnimation ver.
    @objc func readData5(){
        let animation = CASpringAnimation(keyPath: "position")
        let cordinate = self.userDefaults.object(forKey: "\(projectLabel)_\(2)") as! [[CGFloat]]
        let tag = cordinate.count
        for i in 1...(tag){
            if self.view.viewWithTag(i) != nil {
                let imgL = self.view.viewWithTag(i)
                animation.duration = 1.0
                animation.fromValue = [imgL?.frame.origin.x,imgL?.frame.origin.y]
                let xrange = (imgL?.frame.width)!/2.0
                let yrange = (imgL?.frame.height)!/2.0
                animation.toValue = [xrange + cordinate[i][1],yrange + cordinate[i][2]]
                animation.initialVelocity = 30.0
                animation.damping = 15.0
                animation.stiffness = 120.0
                imgL?.layer.add(animation, forKey: nil)
            }
        }
    }
//===============================================================
//CAKeyframeAnimation ver.
    @objc func readData4(){
        let animation = CAKeyframeAnimation(keyPath: "position")
        //let tag = 4
        for i in 1...(totalTag){
            if self.view.viewWithTag(i) != nil {
                let imgL = self.view.viewWithTag(i)
                let xrange = (imgL?.frame.width)!/2.0
                let yrange = (imgL?.frame.height)!/2.0

                animation.duration = 1.0*Double(self.endpage-1)
                animation.values = [CGPoint(x: xrange + (imgL?.frame.origin.x)!,
                                            y: yrange + (imgL?.frame.origin.y)!)]
                animation.keyTimes = [0.0]
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                //それぞれのラベルに移動する先の座標と開始時間を追加していく
                for j in 2...(endpage){
                    var cordinate = self.userDefaults.object(forKey: "\(projectLabel)_\(j)") as! [[CGFloat]]
                    var tag = cordinate.count
                    while tag < self.totalTag {
                        if tag % 2 == 0 {
                            cordinate.append([0.0,0.0 - self.view.frame.width * 0.5 ,self.view.frame.height/2])
                        }else{
                            cordinate.append([0.0,self.view.frame.width * 1.5,self.view.frame.height/2])
                        }
                        tag = tag + 1
                    }

                    animation.values?.append(CGPoint(x:xrange + cordinate[i][1],
                                                     y:yrange + cordinate[i][2]))
                    animation.keyTimes?.append(NSNumber(value: Double(j-1)/Double(self.endpage-1)))
                }
                // 画像のLayerにアニメーションをセットする
                imgL?.layer.add(animation, forKey: nil)

            }
        }
    }
//===============================================================
    //ラベル作成
    func labelSet(_ label: UILabel,_ tag: Int,_ xrange: CGFloat,_ yrange: CGFloat){
        label.frame = CGRect(x:0,y:0,width:50,height:50)
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        switch tag % 5 {
        case 0: label.layer.borderColor = UIColor.blue.cgColor
        case 1: label.layer.borderColor = UIColor.green.cgColor
        case 2: label.layer.borderColor = UIColor.red.cgColor
        case 3: label.layer.borderColor = UIColor.yellow.cgColor
        case 4: label.layer.borderColor = UIColor.orange.cgColor
        default: break
        }
        label.layer.borderWidth = 5
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25
        label.text = String(tag)
        label.frame = CGRect(x:xrange, y:yrange,width:50,height:50)
        
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
