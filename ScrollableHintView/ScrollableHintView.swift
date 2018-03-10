//
//  ScrollableHintView.swift
//  sampleProject
//
//  Created by Admin on 3/1/18.
//  Copyright © 2018 DhruvinThumar. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(UIColor.white.withAlphaComponent(0.60).cgColor)
        context.fillPath()
    }
}

class ScrollableHintView: UIView {

    // Public Variables
    var hintText = ""
    var hintTextColor = UIColor.black
    var hintViewGradiantColorArray = [UIColor.white.cgColor,UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0).cgColor]
    var hintViewIsHidden = false
    
    // Private Variables
    private var scrollView:UIScrollView!
    private var label:UILabel!
    private var anchorView:TriangleView!
    private var viewY:CGFloat!
    private var anchorXAdj:CGFloat = 0.0
    private var setDown = false
    
    
    required init(viewForLabelToShow:UIView, withWidth:CGFloat, setDownToView:Bool)
    {
        if setDownToView == true
        {
            setDown = true
            viewY = viewForLabelToShow.frame.origin.y + viewForLabelToShow.frame.size.height + 12
        }
        else{
            setDown = false
            viewY = viewForLabelToShow.frame.origin.y - 47
        }
        
        super.init(frame: CGRect(x: (viewForLabelToShow.frame.size.width/2 + viewForLabelToShow.frame.origin.x) - (withWidth/2), y:viewY  , width: withWidth, height: 35))
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        viewForLabelToShow.isUserInteractionEnabled = true
        viewForLabelToShow.addGestureRecognizer(longPressGR)
    
        let screen = UIScreen.main.bounds
        if self.frame.origin.x < 5
        {
            anchorXAdj = abs(self.frame.origin.x) + 5
            self.frame.origin.x = 5
            
        }else if (self.frame.origin.x + self.frame.size.width + 5) > screen.size.width
        {
            anchorXAdj = -(self.frame.origin.x + self.frame.size.width + 5 - screen.size.width)
            self.frame.origin.x += anchorXAdj
        }
        self.isHidden = true
        self.alpha = 0
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.50).cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = hintViewGradiantColorArray
        gradient.cornerRadius = 8
        self.layer.insertSublayer(gradient, at: 0)
        
        let tapGRForHideView = UITapGestureRecognizer(target: self, action: #selector(hideView))
        tapGRForHideView.numberOfTapsRequired = 2
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGRForHideView)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc func hideView(){
        
        if scrollView != nil && label != nil
        {
            self.scrollView.removeFromSuperview()
            self.label.removeFromSuperview()
            self.scrollView = nil
            self.label = nil
            
            self.removeAnimate()
        }
    }
    
    @objc func handleTap(sender:UILongPressGestureRecognizer!){
       
        if (sender.state == UIGestureRecognizerState.began) {
            self.isHidden = false
            self.showAnimate()
            
            if scrollView == nil && label == nil
            {
                
                // Calculate Text Width
                let fontAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)]
                let size = (self.hintText).size(withAttributes: fontAttributes)
                
                // Scroll View
                scrollView = UIScrollView.init(frame: self.bounds)
                scrollView.contentSize = CGSize(width: (size.width) + 6, height:self.frame.size.height)
                scrollView.isUserInteractionEnabled = true
                scrollView.showsVerticalScrollIndicator = false
                scrollView.showsHorizontalScrollIndicator = false
                scrollView.isScrollEnabled = true
                scrollView.backgroundColor = UIColor.clear
                self.addSubview(scrollView)
                
                // Hint LblView
                label = UILabel.init(frame: self.bounds)
                label.frame.size.width = (size.width)
                label.frame.origin.x += 3
                label.textAlignment = .center
                label.text = self.hintText
                label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
                label.isUserInteractionEnabled = true
                label.backgroundColor = UIColor.clear
                label.textColor = hintTextColor
                self.scrollView.addSubview(label)
                
                // Anchor View
                if setDown == true{
                    anchorView = TriangleView.init(frame: CGRect(x: self.bounds.midX - 10 - anchorXAdj, y: -10, width: 20, height: 10))
                    anchorView.layer.borderColor = UIColor.black.cgColor
                    anchorView.backgroundColor = UIColor.clear
                    self.addSubview(anchorView)
                }
                else{
                    
                    anchorView = TriangleView.init(frame: CGRect(x: self.bounds.midX - 10 - anchorXAdj, y:self.bounds.midY * 2, width: 20, height: 10))
                    anchorView.layer.borderColor = UIColor.black.cgColor
                    anchorView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                    anchorView.backgroundColor = UIColor.clear
                    self.addSubview(anchorView)
                }
                
            }
            
        }
        
    }
    
    // Hint View Animtion
    func showAnimate()
    {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.isHidden = true
            }
        });
    }
   
}
