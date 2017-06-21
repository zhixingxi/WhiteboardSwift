//
//  QLDrawView.swift
//  WhiteBoardSwift
//
//  Created by MQL-IT on 2017/6/21.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

import UIKit

enum QLDrawingMode {
    case draw //绘画
    case earse //擦除
    case none //无操作
}

class QLDrawView: UIView {
    private let line_width = 3.0
    fileprivate var lines = [CAShapeLayer]()
    fileprivate var lineColor: UIColor = UIColor.black
    fileprivate var lineWidth = 3.0
    fileprivate var bezierPath: UIBezierPath?
    fileprivate var shapeLayer: CAShapeLayer?
    // 画板模式
    var drawMode: QLDrawingMode = QLDrawingMode.none {
        didSet {
            switch drawMode {
            case .none:
                lineWidth = line_width * 0
                lineColor = UIColor.clear
            case .draw:
                lineWidth = line_width
                lineColor = UIColor.black
            case .earse:
                lineWidth = line_width * 3
                lineColor = UIColor.white
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.white
    }
    
    // 外部调用
    func clearScreen() {
        if lines.count < 1 {
            return
        }
        for layer in lines {
            layer.removeFromSuperlayer()
        }
        lines.removeAll()
    }
}

//MARK: - 代理
extension QLDrawView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startP = pointWithTouchs(touches: touches)
        if event?.allTouches?.count == 1 {
            let path = paintPath(lineWidth: CGFloat(self.lineWidth), startP: startP)
            self.bezierPath = path
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.backgroundColor = UIColor.clear.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineCap = kCALineCapRound
            layer.lineJoin = kCALineJoinRound
            layer.strokeColor = self.lineColor.cgColor
            layer.lineWidth = path.lineWidth
            self.layer.addSublayer(layer)
            self.shapeLayer = layer
            lines.append(layer)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let moveP = pointWithTouchs(touches: touches)
        if event?.allTouches?.count ?? 0 > 1 {
            self.superview?.touchesMoved(touches, with: event)
        } else if event?.allTouches?.count ?? 0 == 1 {
            bezierPath?.addLine(to: moveP)
            shapeLayer?.path = bezierPath?.cgPath
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.allTouches?.count ?? 0 > 1 {
            self.superview?.touchesEnded(touches, with: event)
        }
    }
}

// 绘图相关私有方法
extension QLDrawView {
    
    fileprivate func pointWithTouchs(touches: Set<UITouch>) -> CGPoint {
        guard let touch = touches.first else {return CGPoint(x:0, y:0) }
        return touch.location(in: self)
    }
    
    fileprivate func paintPath(lineWidth: CGFloat, startP: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: startP)
        return path
    }
    
    
}
