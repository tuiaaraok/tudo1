//
//  CountingLabel.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 30/06/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class CountingLabel: UILabel {

    let counterVelocity: Float = 3.0
    
    enum CounterAnimationType {
        case linear
        case easeIn
        case easeOut
    }
    
    enum CounterType {
        case intType
        case floatType
    }

    private var startNumber: Float = 0.0
    private var endNumber: Float = 0.0
    
    private var progress: TimeInterval!
    private var duration: TimeInterval!
    private var lastUpdate: TimeInterval!

    private var timer: Timer?
    
    private var counterType: CounterType!
    private var counterAnimationType: CounterAnimationType!
    
    private var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }
        
        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)
        
        return startNumber + (update * (endNumber - startNumber))
    }
    
    func count(from fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
        
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue() {
        
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }
        
        updateText(value: currentCounterValue)
    }
    
    private func updateText(value: Float) {
        
        switch counterType! {
        case .intType:
            self.text = "\(Int(value))%"
        case .floatType:
            self.text = String(format: "%.2f%", value)
        }
    }
    
    private func updateCounter(counterValue: Float) -> Float {
        
        switch counterAnimationType! {
        case .linear:
            return counterValue
        case .easeIn:
            return pow(counterValue, counterVelocity)
        case .easeOut:
            return 1.0 - pow(1.0 - counterValue, counterVelocity)
        }
    }
    
    private func invalidateTimer() {
        
        timer?.invalidate()
        timer = nil
    }
}
