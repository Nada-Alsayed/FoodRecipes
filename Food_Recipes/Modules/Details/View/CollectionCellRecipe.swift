//
//  CollectionCellRecipe.swift
//  Food_Recipes
//
//  Created by MAC on 04/10/2023.
//

import UIKit

class CollectionCellRecipe: UICollectionViewCell{
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var labelRecipeName: UILabel!
    @IBOutlet weak var labelChefName: UILabel!
    @IBOutlet weak var labelPike: UILabel!
    @IBOutlet weak var labelServings: UILabel!
    @IBOutlet weak var myImgBG: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
               let gradientLayer = CAGradientLayer()
               gradientLayer.frame = myImgBG.bounds

               // Define the colors for the gradient
               let startColor = UIColor.black.cgColor
               let endColor = UIColor.clear.cgColor
               gradientLayer.colors = [startColor, endColor]

               // Specify the start and end points of the gradient
               gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
               gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)

               // Add the gradient layer to your view's layer
        myImgBG.layer.addSublayer(gradientLayer)
    }
}
 


