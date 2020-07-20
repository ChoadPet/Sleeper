//
//  RSBaseView.swift
//  Sleeper
//
//  Created by user on 20.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit

class RSBaseView: UIView {
    
    /// By default return `false`, if children return `true`
    /// should specify view to be `viewToHighlight`
    var shouldHighlightView: Bool {
        return false
    }
    
    /// By default return `nil`, means no view will highlighted
    var viewToHighlight: UIView? {
        return nil
    }
    
    var highlightColor: UIColor {
        return .separator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard shouldHighlightView, isDesireViewTouched(touches) else {
            print("Can not highlight desire view.")
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            self.viewToHighlight?.backgroundColor = self.highlightColor
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard shouldHighlightView else { return }
        
        UIView.animate(withDuration: 0.2) {
            self.viewToHighlight?.backgroundColor = .clear
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard shouldHighlightView else { return }
        
        UIView.animate(withDuration: 0.2) {
            self.viewToHighlight?.backgroundColor = .clear
        }
    }
    
    /// Don't call super if you don't use `.xib` file!
    func customInit() {
        let nibName = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
    }
    
    private func isDesireViewTouched(_ touches: Set<UITouch>) -> Bool {
        guard let desireView = viewToHighlight, let touch = touches.first else { return false }
        return desireView.bounds.contains(touch.location(in: desireView))
    }
}

