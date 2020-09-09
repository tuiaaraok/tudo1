//
//  AnimatedCircle.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 23/08/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class AnimatedCircle {
    
    private var shapeLayer: CAShapeLayer!
    private var pulsatingLayer: CAShapeLayer!
    
    func  setupNotificationObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
                  
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }

    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, _ view: UIView) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: 100,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 25
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = view.center
            
        return layer
    }
       
    func setupPersentageLabel(_ view: UIView, _ persentageLabel: UILabel) {
        
        view.addSubview(persentageLabel)
        persentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        persentageLabel.center = view.center
    }
          
    func setupCircleLayers(_ view: UIView) {
        
        pulsatingLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0.4934810209, green: 0.4569445994, blue: 0.9211666127, alpha: 1), fillColor: .clear, view)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
               
        let trackLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0.6542259203, green: 0.6316158589, blue: 1, alpha: 1), fillColor: .clear, view)
        view.layer.addSublayer(trackLayer)
               
        shapeLayer = createCircleShapeLayer(strokeColor: .white, fillColor: .clear, view)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
               
        view.layer.addSublayer(shapeLayer)
    }
          
    private  func animatePulsatingLayer () {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
              
        animation.toValue = 1.2
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
              
        pulsatingLayer.add(animation, forKey: "pulsing")
    }

    func beginCountOfPercent(_ persentageLabel: CountingLabel, _ persentage: Float!) {
           
        shapeLayer.strokeEnd = 0

        persentageLabel.text = "\(Int(persentage! * 100))%"
        shapeLayer.strokeEnd = CGFloat(persentage!)
        persentageLabel.count(from: 0,
                              to: persentage! * 100,
                              withDuration: 1,
                              andAnimationType: .easeIn,
                              andCounterType: .intType)
         
        animateCircle()
    }
            
    private func animateCircle() {
           
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
              
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
              
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }

    func setText(congratsLabel: UILabel, textLabel: UILabel, _ persentage: Float!) {
           
        switch persentage * 100 {
        case 0...30:
            congratsLabel.text = ""
            textLabel.text = "Не забудьте выполнить оставшуюся часть заданий"
        case 31...49:
            congratsLabel.text = ""
            textLabel.text = "Остались невыполненные задания!"
        case 50...60:
            congratsLabel.text = "Хороший результат!"
            textLabel.text = "Половина пути пройдена!"
        case 61...80:
            congratsLabel.text = "Так держать!"
            textLabel.text = "Большая часть заданий уже выполнена!"
        case 81...99:
            congratsLabel.text = "Отлично! Вы почти у цели!"
            textLabel.text = "Осталось совсем чуть-чуть!"
        case 100:
            congratsLabel.text = "Поздравляем!"
            textLabel.text = "Вы стремительно идете вперед к своей цели!"
        case 101...1000:
            congratsLabel.text = "Превосходно!"
            textLabel.text = "Вы выполнили больше заданий, чем планировали!"
        default:
            break
        }
    }
}
