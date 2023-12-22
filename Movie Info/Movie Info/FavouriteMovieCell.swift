//
//  FavouriteMovieCell.swift
//  Movie Info
//
//  Created by Jay Doshi on 2023-12-08.
//

import UIKit

class FavouriteMovieCell: UITableViewCell {
    
    
    @IBOutlet weak var FavouriteMovieImageView: UIImageView!
    @IBOutlet weak var FavouriteMovieTitle: UILabel!
    @IBOutlet weak var FavouriteMoviePopularity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
