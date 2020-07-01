//
//  FinishViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 06/06/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    
    
    
    @IBOutlet var congratsLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var willDoButton: UIButton!
    @IBOutlet var toMainButton: UIButton!
    
 
    
    var indexPath: IndexPath!
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    var task: Answer!
    var persentage: Float!
    
    let persentageLabel: CountingLabel = {
          let label = CountingLabel()
          label.text = "0%"
          label.textAlignment = .center
          label.font = UIFont.boldSystemFont(ofSize: 32)
       label.textColor =  .white
          return label
      }()
       
    
    
    
    
    
    private func  setupNotificationObservers() {
          NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            }
            
    @objc private func handleEnterForeground() {
                animatePulsatingLayer()
            }

    
    
    
    
       

    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                layer.path = circularPath.cgPath
                layer.strokeColor = strokeColor.cgColor
                layer.lineWidth = 25
                layer.fillColor = fillColor.cgColor
                layer.lineCap = CAShapeLayerLineCap.round
        layer.position = view.center
      
           return layer
       }
       
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        task = tasksLists[indexPath.row]
      // print("\(task.overDo) vfvf")
        
        guard let countofTask = Int(task.countOfTask) else {return}
        persentage = Float(task.currentNumber) / Float(countofTask)
        print("task current num\(task.currentNumber)")
        
        congratsLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        willDoButton.translatesAutoresizingMaskIntoConstraints = false
        toMainButton.translatesAutoresizingMaskIntoConstraints = false
        
        createConstraints()
        setText()
    }
       
    
    
    
    
    
    
    
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
        setupNotificationObservers()
        setupCircleLayers()
        setupPersentageLabel()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(50), execute: {
               self.beginCountOfPercent()
        })
      
    }
    
    
    
    private func setupPersentageLabel() {
        view.addSubview(persentageLabel)
        persentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        persentageLabel.center = view.center
       }
       
       
       
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0.4934810209, green: 0.4569445994, blue: 0.9211666127, alpha: 1), fillColor: .clear)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
            
        let trackLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0.6542259203, green: 0.6316158589, blue: 1, alpha: 1), fillColor: .clear)
        view.layer.addSublayer(trackLayer)
            
        shapeLayer = createCircleShapeLayer(strokeColor: .white, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
            
        view.layer.addSublayer(shapeLayer)
        
    }
       
    private func animatePulsatingLayer () {
        let animation = CABasicAnimation(keyPath: "transform.scale")
           
        animation.toValue = 1.2
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
           
        pulsatingLayer.add(animation, forKey: "pulsing")
    }

       
       

    private func beginCountOfPercent() {
        
        shapeLayer.strokeEnd = 0

        persentageLabel.text = "\(Int(persentage! * 100))%"
        print(persentage!)
        shapeLayer.strokeEnd = CGFloat(persentage!)
        persentageLabel.count(
            from: 0,
            to: persentage! * 100,
            withDuration: 1,
            andAnimationType: .easeIn,
            andCounterType: .intType
        )
      
        animateCircle()
             
    }
         
       

       
    
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
           
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
           
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
       

    
    
    
    private func setText() {
        
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
    
    
    

       func createConstraints() {
           
        congratsLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                    
        congratsLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true
                    
        congratsLabel.centerYAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 60
            ).isActive = true
                    
        congratsLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
   
        
        
        
        textLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true

        textLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true

        textLabel.centerYAnchor.constraint(
            equalTo: congratsLabel.bottomAnchor,
            constant: 30
            ).isActive = true

        textLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true




        willDoButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true

        willDoButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true

        willDoButton.centerYAnchor.constraint(
            equalTo: toMainButton.topAnchor,
            constant: -18
            ).isActive = true

        willDoButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true




        toMainButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true

        toMainButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true

        toMainButton.centerYAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -60
            ).isActive = true

        toMainButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
}
}
