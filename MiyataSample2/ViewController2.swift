//
//  ViewController2.swift
//  MiyataSample3
//
//  Created by 宮田恵里 on 2017/10/04.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var tagnumber: Int = 0
    var pagenumber: Int = 0
    var bool: Bool = false
    var endpage: Int = 0
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //前のページのデータを読み込む
        readData()

        if endpage == pagenumber {
            bool = false
        }
        
        self.view.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0)
        let screenWidth: CGFloat = self.view.frame.width
        let screenHeight: CGFloat = self.view.frame.height
        
        //追加ボタン
        let button = UIButton()
        button.frame = CGRect(x:screenWidth/2-50, y:screenHeight-100, width: 100, height: 50)
        button.setTitle("＋", for:UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize:24)
        button.backgroundColor = UIColor.white //init(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25

        button.addTarget(self, action: #selector(ViewController2.add(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        //次へのボタン
        let nextbutton = UIButton()
        nextbutton.frame = CGRect(x:screenWidth/2+100, y:screenHeight-100, width:50, height:50)
        nextbutton.setTitle("→", for: UIControlState.normal)
        nextbutton.setTitleColor(UIColor.green, for: .normal)
        nextbutton.titleLabel?.font = UIFont.systemFont(ofSize:24)
        nextbutton.backgroundColor = UIColor.white //init(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        nextbutton.layer.masksToBounds = true
        nextbutton.layer.cornerRadius = 25

        nextbutton.addTarget(self, action: #selector(ViewController2.next(sender:)), for: .touchUpInside)
        self.view.addSubview(nextbutton)
            
        //前へのボタン
        let prevButton = UIButton()
        prevButton.frame = CGRect(x:screenWidth/2-150, y:screenHeight-100, width:50, height:50)
        prevButton.setTitle("←", for: UIControlState.normal)
        prevButton.setTitleColor(UIColor.green, for: .normal)
        prevButton.titleLabel?.font = UIFont.systemFont(ofSize:24)
        prevButton.backgroundColor = UIColor.white //init(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        prevButton.layer.masksToBounds = true
        prevButton.layer.cornerRadius = 25

        prevButton.addTarget(self, action: #selector(ViewController2.prev(sender:)), for: .touchUpInside)
        self.view.addSubview(prevButton)
        
        //saveのボタン
        let savebutton = UIButton()
        savebutton.frame = CGRect(x:60, y:50, width:50, height:50)
        savebutton.setTitle("save", for: UIControlState.normal)
        savebutton.setTitleColor(UIColor.black, for: .normal)
        savebutton.titleLabel?.font = UIFont.systemFont(ofSize:24)
        savebutton.backgroundColor = UIColor.white //init(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        savebutton.addTarget(self, action: #selector(ViewController2.save(sender:)), for: .touchUpInside)
        self.view.addSubview(savebutton)
        
        //右上にページ数表示
        let pagelabel = UILabel()
        pagelabel.frame = CGRect(x:340,y:50,width:50,height:50)
        pagelabel.backgroundColor = UIColor.white
        pagelabel.textAlignment = NSTextAlignment.center
        //　ラベル枠の枠線太さと色
        pagelabel.layer.borderColor = UIColor.blue.cgColor
        pagelabel.layer.borderWidth = 2
        // ラベル枠を丸くする
        pagelabel.layer.masksToBounds = true
        // ラベル丸枠の半径
        pagelabel.layer.cornerRadius = 25
        pagelabel.text = String(pagenumber)
        self.view.addSubview(pagelabel)

    }
    
    /*追加ボタン押した時の動作*/
    @objc internal func add(sender: AnyObject){
            
        let imageCute = UIImageView()
        imageCute.image = UIImage(named: "cute")
        let rect = CGRect(x:0, y:0, width: 50, height:50)
        imageCute.frame = rect
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        imageCute.center = CGPoint(x:screenWidth/2 + CGFloat(5 * tagnumber), y:screenHeight/2 + CGFloat(5 * tagnumber))
        imageCute.isUserInteractionEnabled = true
            
        imageCute.tag = tagnumber
        self.view.addSubview(imageCute)
        tagnumber = tagnumber + 1
    }
    
    /* イメージをタッチした瞬間 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
    
    /* イメージを動かしているとき */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        for touch in touches {
            let imgC: UIImageView = touch.view as! UIImageView
            let touchEvent: AnyObject = touches.first!
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            let dx = newDx - preDx
            let dy = newDy - preDy
            
            var viewFrame: CGRect = imgC.frame
            
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
                
            imgC.frame = viewFrame
            self.view.addSubview(imgC)
        }
        
    }
    
    /* イメージから指が離れた瞬間 */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("End")
        for touch in touches {
            if let frame = touch.view?.frame {
                print("x: \(frame.origin.x), y: \(frame.origin.y)")
            }
        }
    }
    
    /* 次へのボタンを押した時の動作 */
    @objc internal func next(sender: AnyObject){
        let storyboard: UIStoryboard = self.storyboard!
        var cordinate = [[CGFloat]](repeating: [CGFloat](repeating: 0,count: 3),count: tagnumber)
//        var cordinate  = [String: CGFloat]() //辞書型ver
        for i in 1..<(tagnumber) {
            if let view = self.view.viewWithTag(i){
                let viewFrame: CGRect = view.frame
                let x = viewFrame.origin.x
                let y = viewFrame.origin.y
                cordinate[i][1] = x //配列ver
                cordinate[i][2] = y //配列ver
//                cordinate["x\(i)"] = x //辞書型ver
//                cordinate["y\(i)"] = y //辞書型ver

            }
                      
            userDefaults.set(cordinate, forKey: "Formation\(pagenumber)")
            userDefaults.synchronize()
        }
       
        /* 次の画面へ遷移 コードver. */
        let nextVC: ViewController2 = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        nextVC.tagnumber = self.tagnumber
        nextVC.pagenumber = self.pagenumber + 1
        nextVC.bool = self.bool
        nextVC.endpage = self.endpage
        present(nextVC, animated: true, completion: nil)
    }
    
    /* 前へのボタンを押した時の動作 */
    @objc internal func prev(sender: AnyObject){      
        self.dismiss(animated: true, completion: nil)
    }
    
    /* saveボタンを押した時の動作 */
    @objc internal func save(sender: AnyObject){
        let storyboard: UIStoryboard = self.storyboard!
        var cordinate = [[CGFloat]](repeating: [CGFloat](repeating: 0,count: 3),count: tagnumber)
        for i in 1..<(tagnumber) {
            if let view = self.view.viewWithTag(i){
                let viewFrame: CGRect = view.frame
                let x = viewFrame.origin.x
                let y = viewFrame.origin.y
                cordinate[i][1] = x //配列ver
                cordinate[i][2] = y //配列ver
            }
            userDefaults.set(cordinate, forKey: "Formation\(pagenumber)")
            userDefaults.synchronize()
        }
        
        /* 次の画面へ遷移 コードver. */
        let tableVC: TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        tableVC.bool = true
        tableVC.endpage = self.pagenumber
        present(tableVC, animated: true, completion: nil)
    }

    /*前の画面のデータを読み込む関数*/
    func readData(){
        var page = Int()
        //print(bool)
        if bool == true{
            page = pagenumber
        }else{
            page = pagenumber - 1
        }
        
        let cordinate = userDefaults.object(forKey: "Formation\(page)") as! [[CGFloat]]
        let tag = cordinate.count
        //let tag: Int = tagnumber
        //print(tag)
        //print(tagnumber)
        for i in 1..<(tag){
            let imageCute = UIImageView()
            imageCute.image = UIImage(named: "cute")
            imageCute.tag = i
            let rect = CGRect(x:cordinate[i][1], y:cordinate[i][2], width: 50, height:50)
            imageCute.frame = rect
            print(imageCute.frame)
            imageCute.isUserInteractionEnabled = true
            tagnumber = tag
            self.view.addSubview(imageCute)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

