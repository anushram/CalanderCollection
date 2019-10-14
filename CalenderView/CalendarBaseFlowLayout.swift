//
//  CalendarBaseFlowLayout.swift
//  CalendarView
//
//  Created by K Saravana Kumar on 02/07/19.
//  Copyright © 2019 K Saravana Kumar. All rights reserved.
//

import UIKit

class CalendarBaseFlowLayout: UICollectionViewFlowLayout {
    
    var layoutInfo: [Int: [IndexPath:UICollectionViewLayoutAttributes]] = [Int: [IndexPath:UICollectionViewLayoutAttributes]]()
    
    var layoutInfoSection: [IndexPath:UICollectionViewLayoutAttributes] =  [IndexPath:UICollectionViewLayoutAttributes]()
    
    var yCellSectionOffset: CGFloat   = 0.0
    
    override init() {
        super.init()
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        // setting up some inherited values
        
    }
    override func prepare() {
        guard let collectionview = self.collectionView else {
            return
        }
        self.itemSize = CGSize(width: (self.collectionView?.frame.size.width)!/14 - 5, height: (self.collectionView?.frame.size.width)!/14 - 5)
        
        
        
        guard let sectionCount = self.collectionView?.numberOfSections else {
            return
        }
        
        for k in 0 ..< sectionCount {
            
            let indexPath = IndexPath(item: 0, section: k)
            
            let itemAttributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
            
            itemAttributes.frame = self.frameForSectionAtIndexPath(indexPath: indexPath, attribute: itemAttributes)
            
            layoutInfoSection[indexPath] = itemAttributes
            
        }
        
        for i in 0 ..< sectionCount {
            
            guard let itemCount = self.collectionView?.numberOfItems(inSection: i) else {
                return
            }
            
            var layoutInfoArray : [IndexPath:UICollectionViewLayoutAttributes] = [IndexPath:UICollectionViewLayoutAttributes]()
            
            
            for j in 0 ..< itemCount {
                
                let indexPathAtrribute = IndexPath(item: 0, section: i)
                
                let sectAttributes = layoutInfoSection[indexPathAtrribute]
                
                let indexPath = IndexPath(item: j, section: i)
                
                let itemAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                
                itemAttributes.frame = self.frameForItemAtIndexPath(indexPath: indexPath, attribute: itemAttributes, attributeSection: sectAttributes!)
                
                layoutInfoArray[indexPath] = itemAttributes
                
            }
            
            layoutInfo[i] = layoutInfoArray
            
        }
        
        

    }
    
    func frameForItemAtIndexPath(indexPath: IndexPath,attribute: UICollectionViewLayoutAttributes,attributeSection: UICollectionViewLayoutAttributes) -> CGRect {
        
    //    if attribute.indexPath.section/2 == 0 {
        
        var xCellOffset = CGFloat(attribute.indexPath.item % 7) * self.itemSize.width
        
        var yCellOffset = CGFloat(attribute.indexPath.item / 7) * self.itemSize.height
        
        let secOffSet = attribute.indexPath.section % 2
        
        if secOffSet == 0 {
            xCellOffset += CGFloat(secOffSet) * ((self.collectionView?.frame.size.width)!/2) + 20
        }else {
            
            xCellOffset += CGFloat(secOffSet) * ((self.collectionView?.frame.size.width)!/2) + 20
            
        }
            
            let secOffSetY = attribute.indexPath.section / 2
            
            yCellOffset += (attributeSection.frame.origin.y + 58.0)
        
            let rect: CGRect = CGRect(x: xCellOffset, y: yCellOffset, width: self.itemSize.width, height: self.itemSize.height)
        
        return rect
//        }else{
//
//            var xCellOffset = CGFloat(attribute.indexPath.item % 7) * self.itemSize.width
//
//            let yCellOffset = CGFloat(attribute.indexPath.item / 7) * self.itemSize.height
//
//            let secOffSet = attribute.indexPath.section
//
//            xCellOffset += CGFloat(secOffSet) * ((self.collectionView?.frame.size.width)!/2)
//
//            let rect: CGRect = CGRect(x: xCellOffset + (self.collectionView?.frame.size.width)!/2, y: yCellOffset, width: self.itemSize.width, height: self.itemSize.height)
//
//            return rect
//
//        }
        
    }
    
    func frameForSectionAtIndexPath(indexPath: IndexPath,attribute: UICollectionViewLayoutAttributes) -> CGRect {
        
        //    if attribute.indexPath.section/2 == 0 {
        
        let xCellOffset = CGFloat(attribute.indexPath.section % 2) * ((self.collectionView?.frame.size.width)!/2) + 20
        
        yCellSectionOffset = CGFloat(attribute.indexPath.section / 2) * (6 * self.itemSize.height)
        
        var secHeightValue = CGFloat(attribute.indexPath.section / 2) * 58.0
        
        
        //xCellOffset += CGFloat(secOffSet) * ((self.collectionView?.frame.size.width)!/2)
        
        let secOffSetY = attribute.indexPath.section / 2
        
        yCellSectionOffset += CGFloat(secOffSetY) + secHeightValue
        //(self.collectionView?.frame.size.width)!/2
        let rect: CGRect = CGRect(x: xCellOffset, y: yCellSectionOffset, width: self.itemSize.width * 7, height: 58.0)
        
        return rect
        
        
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        //        if let attrs = super.layoutAttributesForItem(at: indexPath) {
        //            let attrscp = attrs.copy() as! UICollectionViewLayoutAttributes
        //            self.applyLayoutAttributes(attrscp)
        //            return attrscp
        //        }
        //        return nil
        
        return layoutInfo[indexPath.section]?[indexPath]
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //        return super.layoutAttributesForElements(in: rect)?.map { attrs in
        //            let attrscp = attrs.copy() as! UICollectionViewLayoutAttributes
        //            self.applyLayoutAttributes(attrscp)
        //            return attrscp
        //        }
        
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        
        for (_,value) in layoutInfo {
            
            for (_, attributes) in value {
                if rect.intersects(attributes.frame) {
                    allAttributes.append(attributes)
                }
            }
            
        }
        
        allAttributes += layoutInfoSection.values
        
        return allAttributes
        
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?{
        
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            return layoutInfoSection[indexPath]
        default:
            break
        }
        
        return layoutInfoSection[indexPath]
        
    }
    
    func applyLayoutAttributes(_ attributes : UICollectionViewLayoutAttributes) {
        
        if attributes.indexPath.section/2 == 0 {
        
        guard attributes.representedElementKind == nil else { return }
        
        guard let collectionView = self.collectionView else { return }
        
        var xCellOffset = CGFloat(attributes.indexPath.item % 7) * self.itemSize.width
        var yCellOffset = CGFloat(attributes.indexPath.item / 7) * self.itemSize.height
        
        let offset = CGFloat(attributes.indexPath.section)
        
        xCellOffset += offset * collectionView.frame.size.width
        
        //        switch self.scrollDirection {
        //        case .horizontal:   xCellOffset += offset * collectionView.frame.size.width
        //        case .vertical:     yCellOffset += offset * collectionView.frame.size.height
        //        }
        
        // set frame
        attributes.frame = CGRect(
            x: xCellOffset,
            y: yCellOffset,
            width: self.itemSize.width,
            height: self.itemSize.height
        )
        }else {
            
            guard attributes.representedElementKind == nil else { return }
            
            guard let collectionView = self.collectionView else { return }
            
            var xCellOffset = CGFloat(attributes.indexPath.item % 7) * self.itemSize.width
            var yCellOffset = CGFloat(attributes.indexPath.item / 7) * self.itemSize.height
            
            let offset = CGFloat(attributes.indexPath.section)
            
            xCellOffset += offset * collectionView.frame.size.width
            
            //        switch self.scrollDirection {
            //        case .horizontal:   xCellOffset += offset * collectionView.frame.size.width
            //        case .vertical:     yCellOffset += offset * collectionView.frame.size.height
            //        }
            
            // set frame
            attributes.frame = CGRect(
                x: xCellOffset + (self.collectionView?.frame.size.width)!/2,
                y: yCellOffset,
                width: self.itemSize.width,
                height: self.itemSize.height
            )
            
        }
    }
    
    override var collectionViewContentSize: CGSize {
        //        let collectionViewHeight = self.collectionView!.frame.height
        let collectionViewWidth = self.collectionView!.frame.width
        
        let addedValue = 58.0 * Float((self.collectionView?.numberOfSections)!/2).rounded(FloatingPointRoundingRule.awayFromZero)
        //        let contentWidth: CGFloat = maxXPos + itemWidth
        let contentHeight: CGFloat = (CGFloat(Int(6 * (self.itemSize.height)) * ((self.collectionView?.numberOfSections)!/2))) + CGFloat(addedValue)
        
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }

}
