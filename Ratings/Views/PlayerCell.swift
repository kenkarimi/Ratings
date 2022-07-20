//
//  PlayerCell.swift
//  Ratings
//
//  Created by Kennedy Karimi on 20/06/2022.
//

import UIKit

class PlayerCell: UITableViewCell {
    //references we use to update the elements on the cell.
    //IBOutlet is a keyword for the storyboard and is short for Interface Builder Outlet. It tells the compiler that those properties will connect to some views on the storyboard.
    //Unlike the UITableViewCell(PlayerCell) where we give it an identifier in the attribute inspector to identify it for when we dequeueReusableCell. We can't do that for our 2 text labels and ratingImageView. So we use IBOutlet as we've done below, so that with this PlayerCell class selected in the identity inspector, gameLabel, nameLabel & ratingImageView properties are all now available in the connections inspector as outlets we can 'drag' to attach outlets/create relationships with the actual elements in the connections inspector.
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var player: Player? { //computed property with a block that's executed when it's value is set. Block will set the values on three components connected to the cell.
        didSet {
            guard let player = player else { return }
            
            gameLabel.text = player.game
            nameLabel.text = player.name
            ratingImageView.image = image(forRating: player.rating)
        }
    }
    
    private func image(forRating rating: Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
