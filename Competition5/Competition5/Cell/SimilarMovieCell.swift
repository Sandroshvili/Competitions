//
//  SimilarMovieCell.swift
//  Competition5
//
//  Created by Sandroshvili on 7/3/20.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

class SimilarMovieCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            imgView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        imgView.image = nil
    }

}
