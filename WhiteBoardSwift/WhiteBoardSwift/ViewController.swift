//
//  ViewController.swift
//  WhiteBoardSwift
//
//  Created by MQL-IT on 2017/6/21.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingView: QLDrawView!
    @IBOutlet weak var drawBtn: UIButton!
    @IBOutlet weak var eraseBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBtn.setTitleColor(UIColor.red, for: .selected)
        eraseBtn.setTitleColor(UIColor.red, for: .selected)
    }
    
    
    @IBAction func draw(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        drawingView.drawMode = sender.isSelected ? .draw : .none
        eraseBtn.isSelected = false
    }

    
    @IBAction func erase(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        drawingView.drawMode = sender.isSelected ? .earse : .none
        drawBtn.isSelected = false
    }
    
    @IBAction func clear(_ sender: UIButton) {
        drawingView.clearScreen()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

