//
//  ArrayExtension.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 17/06/15.
//  Copyright © 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

extension Array {
    func at (i:Int) -> Element? {
        if (i<0 || i > self.count - 1)
        {
            return nil
        }
        else
        {
            return self[i]
        }
    }
    
    //Fisher-Yates
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let c = list.count
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    func pickWordRadomlyWheighted<C: MutableCollectionType where C.Index == Int>()  -> Word
    {
        let rand_no = (Float(arc4random()) / Float(UINT32_MAX))
        for i in 0..<(self.count) {
            
            if (Double(rand_no) < Double((self[i] as! Word).GETPriority())/5.0)
            {
                return (self[i] as! Word)
            }
        }
        
        return self[-1] as! Word
    }
}
