//
//  CellRecipe.swift
//  Food_Recipes
//
//  Created by MAC on 26/05/2023.
//

import UIKit

class CellRecipe: UITableViewCell {

    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var labelRecipeName: UILabel!
    
    @IBOutlet weak var labelChefName: UILabel!
    
    @IBOutlet weak var labelPike: UILabel!
    
   
    @IBOutlet weak var labelServings: UILabel!
    
    @IBOutlet weak var myContentView: UIView!
    
  
    @IBOutlet weak var imgBG: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
               let gradientLayer = CAGradientLayer()
               gradientLayer.frame = imgBG.bounds
               
               // Define the colors for the gradient
               let startColor = UIColor.black.cgColor
               let endColor = UIColor.clear.cgColor
               gradientLayer.colors = [startColor, endColor]
               
               // Specify the start and end points of the gradient
               gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
               gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
               
               // Add the gradient layer to your view's layer
        imgBG.layer.addSublayer(gradientLayer)
            }

    
    override var frame: CGRect{
        get{
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
