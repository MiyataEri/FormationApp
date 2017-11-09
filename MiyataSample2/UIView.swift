//
//  File.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/11/08.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

//import Foundation
private extension ArraySlice {
    
    var startItem: Element {
        return self[self.startIndex]
    }
    
}

extension UIView {
    
    private typealias `Self` = UIView
    
    private static func animate(eachBlockDuration duration: TimeInterval, eachBlockDelay delay: TimeInterval, eachBlockOptions options: UIViewAnimationOptions, animationArraySlice: ArraySlice<() -> Void>, completion: ((_ finished: Bool) -> Void)?) {
        
        let animation = animationArraySlice.startItem
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: animation) { (finished) in
            
            let remainedAnimations = animationArraySlice.dropFirst()
            
            if remainedAnimations.isEmpty {
                completion?(finished)
                
            } else {
                Self.animate(eachBlockDuration: duration, eachBlockDelay: delay, eachBlockOptions: options, animationArraySlice: remainedAnimations, completion: completion)
            }
            
        }
        
    }
    
    public static func animate(eachBlockDuration duration: TimeInterval, eachBlockDelay delay: TimeInterval = 0, eachBlockOptions options: UIViewAnimationOptions = .curveEaseInOut, animationBlocks: (() -> Void)..., completion: ((_ finished: Bool) -> Void)? = nil) {
        
        let isFinished = animationBlocks.isEmpty
        
        guard isFinished == false else {
            completion?(isFinished)
            return
        }
        
        let animationArraySlice = ArraySlice(animationBlocks)
        
        Self.animate(eachBlockDuration: duration, eachBlockDelay: delay, eachBlockOptions: options, animationArraySlice: animationArraySlice, completion: completion)
        
    }
    
}
