//
//  ViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/04.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* プロジェクト名代入 */
    @IBOutlet weak var label: UILabel!
    var textVC: String = ""
    
    var tagnumber: Int = 1
    var pagenumber: Int = 1
    var bool: Bool = false
    var saveBool: Bool = false
    var endpage: Int = 1
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロジェクト名
        label.text = textVC
        
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

        button.addTarget(self, action: #selector(ViewController.add(sender:)), for: .touchUpInside)
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

        nextbutton.addTarget(self, action: #selector(ViewController.next(sender:)), for: .touchUpInside)
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
        prevButton.addTarget(self, action: #selector(ViewController.prev(sender:)), for: .touchUpInside)
        self.view.addSubview(prevButton)
        
        //saveのボタン
        let savebutton = UIButton()
        savebutton.frame = CGRect(x:60, y:70, width:50, height:50)
        savebutton.setTitle("save", for: UIControlState.normal)
        savebutton.setTitleColor(UIColor.black, for: .normal)
        savebutton.titleLabel?.font = UIFont.systemFont(ofSize:24)
        savebutton.backgroundColor = UIColor.white //init(red:0.9, green:0.9, blue:0.9, alpha:1.0)
        savebutton.addTarget(self, action: #selector(ViewController.save(sender:)), for: .touchUpInside)
        self.view.addSubview(savebutton)

        
        //右上にページ数表示
        let pagelabel = UILabel()
        pagelabel.frame = CGRect(x:340,y:70,width:50,height:50)
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
        
        //保存されたデータがあるかどうか
        print("\(String(describing: textVC))")
        print("\(pagenumber)")
        if self.userDefaults.object(forKey: "\(textVC)_\(pagenumber)") != nil {
            saveBool = true
        }else{
            saveBool = false
        }

        if bool == false && saveBool == false {
            return
        }else{
            readData()
        }
//
//
//        if endpage == pagenumber {
//            saveBool = false
//        }
//
    }
    
    /* 追加ボタンを押した時の動作 */
    @objc internal func add(sender: AnyObject){
        
        let imageCute = UIImageView()
        imageCute.image = UIImage(named: "cute")
        let rect = CGRect(x:0, y:0, width: 50, height:50)
        imageCute.frame = rect
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        imageCute.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
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
        
        //触っているもののみ、ループする
        for touch in touches {
            if let imgC: UIImageView = touch.view as? UIImageView{
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
        //var cordinate  = [String: CGFloat]() //辞書型ver

        /* イメージの座標を保存する */
        for i in 1..<(tagnumber) {
            if let view = self.view.viewWithTag(i){
                let viewFrame: CGRect = view.frame
                let x = viewFrame.origin.x
                let y = viewFrame.origin.y
                cordinate[i][1] = x //配列ver
                cordinate[i][2] = y //配列ver
                //cordinate["x\(i)"] = x //辞書型ver
                //cordinate["y\(i)"] = y //辞書型ver

            }

            userDefaults.set(cordinate, forKey: "\(textVC)_\(pagenumber)")
            userDefaults.synchronize()
        }
        bool = true
        /* 次の画面へ遷移 コードver. */
        let nextVC: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextVC.tagnumber = self.tagnumber
        pagenumber = pagenumber + 1
        nextVC.pagenumber = self.pagenumber
        nextVC.bool = self.bool
        nextVC.saveBool = self.saveBool
        nextVC.endpage = self.endpage
        nextVC.textVC = self.textVC
        present(nextVC, animated: true, completion: nil)

    }
    
    /* 前へのボタンを押した時の動作 */
    @objc internal func prev(sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
    
    //データ読み込み
    func readData(){
        var page = Int()
        if saveBool == true{
            page = pagenumber
        }else{
            page = pagenumber - 1
        }
        let cordinate = userDefaults.object(forKey: "\(textVC)_\(page)") as! [[CGFloat]]
        let tag = cordinate.count
        for i in 1..<(tag){
            let imageCute = UIImageView()
            imageCute.image = UIImage(named: "cute")
            imageCute.tag = i
            let rect = CGRect(x:cordinate[i][1], y:cordinate[i][2], width: 50, height:50)
            imageCute.frame = rect
            imageCute.isUserInteractionEnabled = true
            tagnumber = tag
            self.view.addSubview(imageCute)
        }
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
            userDefaults.set(cordinate, forKey: "\(textVC)_\(pagenumber)")
            userDefaults.synchronize()
        }

        /* 次の画面へ遷移 コードver. */
        let tableVC: TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        tableVC.bool = self.bool
        tableVC.saveBool = true
        tableVC.endpage = self.pagenumber
        present(tableVC, animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let button = sender as? UIBarButtonItem, button === saveButton else{
//            return
//        }
//        let storyboard: UIStoryboard = self.storyboard!
//        var cordinate = [[CGFloat]](repeating: [CGFloat](repeating: 0,count: 3),count: tagnumber)
//        for i in 1..<(tagnumber) {
//            if let view = self.view.viewWithTag(i){
//                let viewFrame: CGRect = view.frame
//                let x = viewFrame.origin.x
//                let y = viewFrame.origin.y
//                cordinate[i][1] = x //配列ver
//                cordinate[i][2] = y //配列ver
//            }
//            userDefaults.set(cordinate, forKey: "Formation\(pagenumber)")
//            userDefaults.synchronize()
//        }
//        
//        /* 次の画面へ遷移 コードver. */
//        let tableVC: TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
//        tableVC.saveBool = true
//        tableVC.endpage = self.pagenumber
//        present(tableVC, animated: true, completion: nil)
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

