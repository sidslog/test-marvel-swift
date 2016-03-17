//
//  CharactersSearchCell.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 3/16/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharactersSearchCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
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
        self.characterImageView.image = nil
    }

}
