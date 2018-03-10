//
//  GoUV.swift
//  sampleProject
//
//  Created by Admin on 2/20/18.
//  Copyright © 2018 DhruvinThumar. All rights reserved.
//

import UIKit

class GoUV: UIViewController {

  
    @IBOutlet weak var imagView: UIImageView!
    
    @IBOutlet weak var steperView: UIStepper!
    
    @IBOutlet weak var buttonView: UIButton!
    
    @IBOutlet weak var lblView: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Go"
        
    }
    
  
    override func viewDidAppear(_ animated: Bool) {

        let stepperView = ScrollableHintView.init(viewForLabelToShow: steperView, withWidth: 150, setDownToView:false)
        stepperView.hintText = "This is a Hint View, easy to use."
        self.view.addSubview(stepperView)
       
        let lblView = ScrollableHintView.init(viewForLabelToShow: self.lblView, withWidth: 120, setDownToView:true)
        lblView.hintText = "Describe label."
        self.view.addSubview(lblView)
        
        let buttonHintView = ScrollableHintView.init(viewForLabelToShow: buttonView, withWidth: 200, setDownToView:false)
        buttonHintView.hintText = "Hello, Welcome to ScrollableHintView. Perform Double tap to remove hint view"
        self.view.addSubview(buttonHintView)
        
        let imgHintView = ScrollableHintView.init(viewForLabelToShow: imagView, withWidth: 260, setDownToView:false)
        imgHintView.hintText = "This is an Image View. Thank you!"
        self.view.addSubview(imgHintView)
      
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
