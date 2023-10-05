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
   
    var cellReciepe : Reciepe!
    var onDeleteTapped: (() -> Void)?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          setupShadow()
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setupShadow()
      }

      private func setupShadow() {
          // Configure the shadow properties here
          self.layer.cornerRadius = 12.0 // Adjust the corner radius as needed
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowOffset = CGSize(width: 0, height: 4) // Adjust the offset as needed
          self.layer.shadowOpacity = 0.8 // Adjust the opacity as needed
          self.layer.shadowRadius = 5.0 // Adjust the shadow radius as needed
          self.layer.masksToBounds = false
      }
    
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
        
        // Add a tap gesture recognizer to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
        imgLike.addGestureRecognizer(tapGesture)
        imgLike.isUserInteractionEnabled = true
        
    }
    @objc func deleteButtonTapped() {
            // Handle the delete action here
            onDeleteTapped?()
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
