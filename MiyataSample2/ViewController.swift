//
//  ViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/04.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var projectLabel: String = ""
    
    var tagnumber: Int = 1
    var pagenumber: Int = 1
    var bool: Bool = false
    var saveBool: Bool = false
    var endpage: Int = 1
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HERE??")
        //プロジェクト名

        self.navigationItem.title = "\(projectLabel)"

        
        //右上にページ数表示
        let pagelabel = UILabel()
        pagelabel.frame = CGRect(x:340,y:100,width:50,height:50)
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
        
        if self.userDefaults.object(forKey: "\(projectLabel)_\(pagenumber)") != nil {
            saveBool = true
        }else{
            saveBool = false
        }

        if bool == false && saveBool == false {
            return
        }else{
            readData()
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let imageLabel = UILabel()
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height

        labelSet(label: imageLabel)
        imageLabel.center = CGPoint(x:screenWidth/2,y:screenHeight/2)
        imageLabel.text = String(tagnumber)
        imageLabel.tag = tagnumber
        imageLabel.isUserInteractionEnabled = true
        self.view.addSubview(imageLabel)
        
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
            if let imgL = touch.view as? UILabel{
                let touchEvent: AnyObject = touches.first!
                let preDx = touchEvent.previousLocation(in: self.view).x
                let preDy = touchEvent.previousLocation(in: self.view).y
                let newDx = touchEvent.location(in: self.view).x
                let newDy = touchEvent.location(in: self.view).y
                let dx = newDx - preDx
                let dy = newDy - preDy
                var viewFrame: CGRect = imgL.frame
                viewFrame.origin.x += dx
                viewFrame.origin.y += dy
                imgL.frame = viewFrame
                self.view.addSubview(imgL)
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

    @IBAction func next(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        var cordinate = [[CGFloat]](repeating: [CGFloat](repeating: 0,count: 3),count: tagnumber)

        /* イメージの座標を保存する */
        for i in 1..<(tagnumber) {
            if let view = self.view.viewWithTag(i){
                let viewFrame: CGRect = view.frame
                let x = viewFrame.origin.x
                let y = viewFrame.origin.y
                cordinate[i][1] = x
                cordinate[i][2] = y
                
            }
            
            userDefaults.set(cordinate, forKey: "\(projectLabel)_\(pagenumber)")
            userDefaults.synchronize()
        }
        bool = true
        
        let navi = storyboard.instantiateViewController(withIdentifier:"NavigationController") as! UINavigationController
        let nextVC = navi.topViewController as! ViewController
        nextVC.tagnumber = self.tagnumber
        pagenumber = pagenumber + 1
        nextVC.pagenumber = self.pagenumber
        nextVC.bool = self.bool
        nextVC.saveBool = self.saveBool
        nextVC.endpage = self.endpage

        nextVC.projectLabel = self.projectLabel
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func prev(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let animeView = storyboard.instantiateViewController(withIdentifier: "animeVC")
//        animeView.endpage = self.endpage
//        animeView.projectLabel = self.projectLabel
        present(animeView, animated: true, completion: nil)
    }
    
    //データ読み込み
    func readData(){
        var page = Int()
        if saveBool == true{
            page = pagenumber
        }else{
            page = pagenumber - 1
        }
        let cordinate = userDefaults.object(forKey: "\(projectLabel)_\(page)") as! [[CGFloat]]
        let tag = cordinate.count
        for i in 1..<(tag){
            
            let imageLabel = UILabel()
            labelSet(label: imageLabel)
            imageLabel.frame = CGRect(x:cordinate[i][1], y:cordinate[i][2],width:50,height:50)
            imageLabel.text = String(i)
            imageLabel.tag = i
            imageLabel.isUserInteractionEnabled = true
            tagnumber = tag
            self.view.addSubview(imageLabel)

        }
    }
    
    func labelSet(label: UILabel){
        label.frame = CGRect(x:0,y:0,width:50,height:50)
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.layer.borderColor = UIColor.yellow.cgColor
        label.layer.borderWidth = 5
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25
    }
    
    @IBAction func returnProject(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            return
        }
        let storyboard: UIStoryboard = self.storyboard!
        var cordinate = [[CGFloat]](repeating: [CGFloat](repeating: 0,count: 3),count: tagnumber)
        for i in 1..<(tagnumber) {
            if let view = self.view.viewWithTag(i){
                let viewFrame: CGRect = view.frame
                let x = viewFrame.origin.x
                let y = viewFrame.origin.y
                cordinate[i][1] = x
                cordinate[i][2] = y
            }
            userDefaults.set(cordinate, forKey: "\(projectLabel)_\(pagenumber)")
            userDefaults.synchronize()
        }
        
        /* 次の画面へ遷移 コードver. */
        let tableVC: TableViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        tableVC.saveBool = true
        tableVC.endpage = self.pagenumber
//        present(tableVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

