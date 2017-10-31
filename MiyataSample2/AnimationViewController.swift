//
//  AnimationViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/31.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var projectLabel: String = "stkgz"
    var endpage: Int = 3
    let userDefaults = UserDefaults.standard
    //var timer:Timer?
    //var number = 0

    var imageLabel: UILabel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        readData(page: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 5.0, delay: 0.0, options: .autoreverse, animations: {
            //                imageLabel.frame = CGRect(x: imageLabel.frame.origin.x + 100,
            //                                            y: imageLabel.frame.origin.y,
            //                                            width: imageLabel.frame.width,
            //                                            height: imageLabel.frame.height)
            self.imageLabel.frame.origin.x += 100
        })
        //self.view.addSubview(imageView)
        //}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //データ読み込み
    func readData(page: Int){
        let cordinate1 = userDefaults.object(forKey: "\(projectLabel)_\(page)") as! [[CGFloat]]
        //let cordinate2 = userDefaults.object(forKey: "\(projectLabel)_\(page+1)") as! [[CGFloat]]

        //let tag = cordinate2.count
        //for i in 1..<(tag){
        let i = 1
            self.imageLabel = UILabel()
            labelSet(imageLabel,i,cordinate1[i][1],cordinate1[i][2])
            self.view.addSubview(imageLabel)

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

 
    
    
    
    
    
//    func startTimer(){
//        if timer == nil {
//            // 0.3s 毎にTemporalEventを呼び出す
//            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:Selector(("TemporalEvent")), userInfo: nil,repeats: true)
//        }
//    }
    //一定タイミングで繰り返し呼び出される関数
//    @objc func TemporalEvent(){
//        //for  i in 1...endpage{
//
//            moveData()
//            number = number + 1
//        //}
//    }
//    func stopTimer(){
//        if timer != nil {
//            timer?.invalidate();timer = nil
//        }
//    }
//
//    func moveData(){
//        let cordinate1 = userDefaults.object(forKey: "\(projectLabel)_\(1)") as! [[CGFloat]]
//        let cordinate2 = userDefaults.object(forKey: "\(projectLabel)_\(2)") as! [[CGFloat]]
//        let tag = cordinate1.count
//        for i in 1..<(tag){
//            let imageLabel = UILabel()
//            labelSet(label: imageLabel)
//            let diffX = (cordinate2[i][1]-cordinate1[i][1]) * CGFloat(number)
//            let diffY = (cordinate2[i][2]-cordinate1[i][2]) * CGFloat(number)
//
//            imageLabel.frame = CGRect(x:cordinate1[i][1]+diffX/50,y:cordinate1[i][2]+diffY/50,width:50,height:50)
//            imageLabel.text = String(i)
//            let imageView = imageLabel as UIView
//
//            self.view.addSubview(imageView)
//        }
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
