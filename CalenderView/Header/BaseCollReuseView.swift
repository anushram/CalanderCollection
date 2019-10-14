//
//  BaseCollReuseView.swift
//  CalendarView
//
//  Created by K Saravana Kumar on 02/07/19.
//  Copyright © 2019 K Saravana Kumar. All rights reserved.
//

import UIKit

class BaseCollReuseView: UICollectionReusableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var sectionDateHeader: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
        
        // Customize here
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
