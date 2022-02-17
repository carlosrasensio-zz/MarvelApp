//
//  CharacterCustomCell.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit

class CharacterCustomCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCustomCell()
    }

    func setCustomCell() {
        self.titleLabel.layer.cornerRadius = self.titleLabel.frame.size.height/2.0
        self.titleLabel.layer.masksToBounds = true
        self.titleLabel.backgroundColor = .red
        self.titleLabel.alpha = 0.8
        self.titleLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
