//
//  CharacterInfoCell.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 16/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterInfoCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var descriptionValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(character: Character) {
        
        if let thumbnail = character.thumbnail, url = thumbnail.resourceURL(.StandardFantastic) {
            self.thumbnailImageView.setImageWithURL(url)
        } else {
            self.thumbnailImageView.image = nil
        }
        self.nameValue.text = character.name
        self.nameLabel.text = character.name.characters.count > 0 ? "NAME" : ""
        
        self.descriptionValue.text = character.descr
        self.descriptionName.text = character.descr.characters.count > 0 ? "DESCRIPTION" : ""
    }

}
