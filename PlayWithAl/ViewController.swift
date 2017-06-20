//
//  ViewController.swift
//  PlayWithAl
//
//  Created by 龚欢 on 2017/6/19.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arr = Helper.generateSources(count: 1_000_000)
        let arr1 = arr
        
        Helper.executeTime(whichFunctionName: "插入排序", testSources: arr, operation: insertionSort)
        Helper.executeTime(whichFunctionName: "选择排序", testSources: arr1, operation: selectionSort)
        
    }
    
    
    /**
     * 选择排序
     */
    func selectionSort(sources: [Int]) -> [Int] {
        
        var sources = sources
        
        for i in 0..<sources.count {
            
            var minIndex = i
            
            for j in i+1..<sources.count  {
                
                if sources[j] < sources[minIndex] {
                    
                    minIndex = j
                }
            }
            
            if minIndex != i {
                swap(&sources[minIndex], &sources[i])
            }
           
        }
        
        return sources
    }
    
    
    /**
     * 插入排序
     */
    func insertionSort(sources: [Int]) -> [Int] {
        
        var sources = sources
        
        for i in 1..<sources.count {

            let e = sources[i]
            var j = i - 1
            
            while ( j >= 0 && sources[j] > e) {
                
                sources[j + 1] = sources[j]
                
                j = j - 1
            }
            
            sources[j+1] = e
        
        }
        
        return sources
    }


}


class Helper {

    static func generateSources(count: Int) -> [Int] {
        var sources: [Int] = [Int]()
        for _ in 1...count {
            let randomNum: UInt32 = arc4random_uniform(10)
            sources.append(Int(randomNum))
        }
        return sources
    }
    
    static func executeTime(whichFunctionName: String, testSources: [Int], operation: ([Int]) -> ([Int])) {
        let methodStart = Date()
        let tt = operation(testSources)
        let methodFinished = Date()
        let executionTime = methodFinished.timeIntervalSince(methodStart)
        print(String(format:"执行%@花费%.9fs", whichFunctionName, executionTime))
        assert(Helper.isSorted(testSources: tt), "排序后还是存在问题！！")
    }
    
    static func isSorted(testSources: [Int]) -> Bool {
        
        if testSources.count < 3 {
            assert(true, "你逗我呢？？就几个自己数")
            return false
        }
        
        
        for i in 0...testSources.count - 2 {
            if testSources[i] > testSources[i + 1] {
                return false
            }
        }
        
        return true
    }
    
    
}

