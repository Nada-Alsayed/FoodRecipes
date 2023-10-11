//
//  Utlites.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import Foundation
import UIKit

class Utlites {
    
    static func registerCell (collectionView: UICollectionView){
        let nib = UINib(nibName: "CategoryCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
    }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func registerTableCell(tableView:UITableView){
        
        tableView.register(UINib(nibName: "CellRecipe", bundle: nil), forCellReuseIdentifier: "CellRecipe")
    }
    
}
