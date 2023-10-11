//
//  DetailsCell.swift
//  Food_Recipes
//
//  Created by MAC on 03/10/2023.
//

import UIKit

class DetailsCell: UICollectionViewCell {

    @IBOutlet var heightCon: NSLayoutConstraint!{  didSet {
        heightCon.isActive = false
    }
}
    
    @IBOutlet weak var myText: UITextView!
    
    var maxHeight: CGFloat? = nil {
        didSet {
            guard let maxHeight = maxHeight else {
                return
            }
            heightCon.isActive = true
            heightCon.constant = maxHeight
        }
        
    }
    override func awakeFromNib() {
            super.awakeFromNib()
            
            myText.isScrollEnabled = false
       // heightCon.constant = myText.contentSize.height
          
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        print("Called")
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)

        // Calculate the size needed for the cell based on the content
        let targetSize = CGSize(width: layoutAttributes.size.width, height: UIView.layoutFittingCompressedSize.height)
        let size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)

        // Update the calculated height for the cell
        attributes.frame.size.height = ceil(size.height)

        return attributes
    }

}
