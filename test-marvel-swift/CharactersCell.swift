//
//  CharactersCell.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 3/16/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharactersCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.backgroundImageView.image = nil
    }
    
}
