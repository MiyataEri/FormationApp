//
//  TitleViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/27.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit
//import Material

class TitleViewController: UIViewController {
    
    var timer:Timer = Timer()
    
//    fileprivate var menuButton: IconButton!
//    fileprivate var starButton: IconButton!
//    fileprivate var searchButton: IconButton!
//
//    fileprivate var nextButton: FlatButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTitle = UIImageView()
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        imageTitle.image = UIImage(named: "title")
        imageTitle.frame = CGRect(x:0, y:0, width:screenWidth/2, height:50)
        imageTitle.center = CGPoint(x:screenWidth/2,y:screenHeight/2)
        self.view.addSubview(imageTitle)
        
//        view.backgroundColor = Color.grey.lighten5
//
//        prepareMenuButton()
//        prepareStarButton()
//        prepareSearchButton()
//        prepareNavigationItem()
//        prepareNextButton()


        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                       target: self,
                                                       selector: #selector(self.changeView),
                                                       userInfo: nil,
                                                       repeats: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeView() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "firstNC")
        //let navi = UINavigationController(rootViewController: nextView)
        // アニメーションの設定
        // navi.modalTransitionStyle = .coverVertical
        present(nextView, animated: true, completion: nil)
//        self.performSegue(withIdentifier: "firstNC", sender: nil)
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
//extension TitleViewController {
//    fileprivate func prepareMenuButton() {
//        menuButton = IconButton(image: Icon.cm.menu)
//    }
//    
//    fileprivate func prepareStarButton() {
//        starButton = IconButton(image: Icon.cm.star)
//    }
//    
//    fileprivate func prepareSearchButton() {
//        searchButton = IconButton(image: Icon.cm.search)
//    }
//    
//    fileprivate func prepareNavigationItem() {
//        navigationItem.titleLabel.text = "Material"
//        navigationItem.detailLabel.text = "Build Beautiful Software"
//        
//        navigationItem.leftViews = [menuButton]
//        navigationItem.rightViews = [starButton, searchButton]
//    }
//    
//    fileprivate func prepareNextButton() {
//        nextButton = FlatButton()
//        nextButton.pulseAnimation = .none
//        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
//        view.layout(nextButton).edges()
//    }
//}
//
//extension TitleViewController {
//    @objc
//    fileprivate func handleNextButton() {
//        navigationController?.pushViewController(TableViewController(), animated: true)
//    }
//}

