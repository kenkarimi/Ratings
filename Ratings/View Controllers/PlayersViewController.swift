//
//  PlayersViewController.swift
//  Ratings
//
//  Created by Kennedy Karimi on 19/06/2022.
//

import UIKit
// "Players Scene"
class PlayersViewController: UITableViewController {
    var playersDataSource = PlayersDataSource()
}

//Extensions are a great way to keep your code organized. You can define them in the same Swift file or in different files. More from the docs: https://docs.swift.org/swift-book/LanguageGuide/Extensions.html
extension PlayersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersDataSource.numberOfPlayers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeueReusableCell returns an instance of a cell with the identifier you provide as a type of UITableViewCell. But since you specified the class of that cell is PlayerCell, it’s safe to cast it accordingly (as! PlayerCell). This way, cell.player will be identifiable as a property of cell. NOTE. In the TODOList app we created, we do not do this. Overall, we used a slighly easier method to bind the data to the list, but the downside of that is in most other app scenarios including this one, too much code would be here as a result.
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.player = playersDataSource.player(at: indexPath)
        return cell
    }
    
    //These actions have to be here since these two methods are Unwind Segues. They are basically exit segues to the view controller they are implemented on. Each button is using its own segue to return from the PlayerDetailsViewController to the PlayersViewController.
    @IBAction func cancelToPlayersViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue){
        guard let playerDetailsViewController = segue.source as? PlayerDetailsViewController, let player = playerDetailsViewController.player else { return }
        playersDataSource.append(player: player, to: tableView)
    }
}
