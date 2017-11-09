//
//  AnimationViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/31.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var projectLabel: String = ""
    let userDefaults = UserDefaults.standard
    var timer:Timer?
    var number = 1
    var endpage = 1//保存されているページの数

    override func viewDidLoad() {
        super.viewDidLoad()
        endpage = userDefaults.object(forKey: "\(projectLabel)_endpage") as! Int
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let cordinate = userDefaults.object(forKey: "\(projectLabel)_\(number)") as! [[CGFloat]]
        let tag = cordinate.count
        
        for i in 1..<(tag){
            let imageLabel = UILabel()
            labelSet(imageLabel,i,cordinate[i][1],cordinate[i][2])
            imageLabel.tag = i
            self.view.addSubview(imageLabel)
        }
        
                UIView.animateKeyframes(withDuration: 1.0*Double(self.endpage-1), delay: 0.0,animations: {
                    for j in 2...(self.endpage){

                    var cordinate = self.userDefaults.object(forKey: "\(self.projectLabel)_\(j)") as! [[CGFloat]]
                    let tag = cordinate.count
                    for i in 1..<(tag){
                        if let imgL = self.view.viewWithTag(i){
                            UIView.addKeyframe(withRelativeStartTime: Double(j-2)/Double(self.endpage-1),
                                               relativeDuration: 1.0/Double(self.endpage-1),
                                               animations: {
                                                imgL.frame = CGRect(x: cordinate[i][1],
                                                                    y: cordinate[i][2],
                                                                    width: imgL.frame.width,
                                                                    height: imgL.frame.height)
                            })
                        }
                    }
                    }


/*===================================================================
                        var cordinate2 = self.userDefaults.object(forKey: "\(self.projectLabel)_\(2)") as! [[CGFloat]]
                        var cordinate3 = self.userDefaults.object(forKey: "\(self.projectLabel)_\(3)") as! [[CGFloat]]
                        let tag = cordinate2.count
                        for i in 1..<(tag){
                            if let imgL = self.view.viewWithTag(i){
                                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                    relativeDuration: 0.5,
                                                    animations: {
                                                    imgL.frame = CGRect(x: cordinate2[i][1],
                                                                        y: cordinate2[i][2],
                                                                        width: imgL.frame.width,
                                                                        height: imgL.frame.height)
                                })
                            }
                    
                    
                            if let imgL = self.view.viewWithTag(i){
                                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5
                                    , animations:{
                                        imgL.frame = CGRect(x: cordinate3[i][1],
                                                            y: cordinate3[i][2],
                                                            width: imgL.frame.width,
                                                            height: imgL.frame.height)

                                })
                            }
                
                    }
=================================================================*/
                } , completion: nil)

//        timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                     target: self,
//                                     selector: #selector(self.readData),
//                                     userInfo: nil,
//                                     repeats: true)

        //readData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editField(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //データ読み込み
    @objc func readData(){
        let cordinate1 = userDefaults.object(forKey: "\(projectLabel)_\(number)") as! [[CGFloat]]
        let cordinate2 = userDefaults.object(forKey: "\(projectLabel)_\(number+1)") as! [[CGFloat]]
        let cordinate3 = userDefaults.object(forKey: "\(projectLabel)_\(number+2)") as! [[CGFloat]]
        
        let tag = cordinate1.count
        
        for i in 1..<(tag){
            let imageLabel = UILabel()
            labelSet(imageLabel,i,cordinate1[i][1],cordinate1[i][2])
            self.view.addSubview(imageLabel)
            imageLabel.tag = i
        }
        
                UIView.animateKeyframes(withDuration: 3.0, delay: 0.0,animations: {
                    for i in 1..<(tag){
                        if let imgL = self.view.viewWithTag(i){
                        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                            imgL.frame = CGRect(x: cordinate2[i][1],
                                                y: cordinate2[i][2],
                                                width: imgL.frame.width,
                                                height: imgL.frame.height)
                        }
                        )
                    }
                    }
                    for i in 1..<(tag){
                    if let imgL = self.view.viewWithTag(i){
                        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5
                            , animations:{
                                imgL.frame = CGRect(x: cordinate3[i][1],
                                                    y: cordinate3[i][2],
                                                    width: imgL.frame.width,
                                                    height: imgL.frame.height)
                        })
                    }
                    }
                }, completion: nil)
    
//-----------------------------------
        //            UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
        //                self.imageLabel.frame = CGRect(x: cordinate2[i][1],
        //                                               y: cordinate2[i][2],
        //                                               width: self.imageLabel.frame.width,
        //                                               height: self.imageLabel.frame.height)
        //            },
        //                           completion: {(finished) in
        //                self.imageLabel.removeFromSuperview()
        //            }
        //            )
        //            //self.imageLabel.removeFromSuperview()
//-----------------------------------
    }
    
    func labelSet(_ label: UILabel,_ tag: Int,_ xrange: CGFloat,_ yrange: CGFloat){
        label.frame = CGRect(x:0,y:0,width:50,height:50)
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.layer.borderColor = UIColor.yellow.cgColor
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
