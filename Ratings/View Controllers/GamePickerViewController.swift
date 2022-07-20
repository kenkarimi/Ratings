//
//  GamePickerViewController.swift
//  Ratings
//
//  Created by Kennedy Karimi on 21/06/2022.
//

import UIKit
// "Choose Game Scene"
class GamePickerViewController: UITableViewController {
    let gamesDataSource = GamesDataSource()
}

//Extensions are a great way to keep your code organized. You can define them in the same Swift file or in different files. More from the docs:
//Talk and think in circles as I have a lot of anxiety around being unclear and being misunderstood so I repeat myself.
extension GamePickerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesDataSource.numberOfGames()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        //We don't subclass the cell this time as we did with PlayerCell since the cells in this scene have their Style set to Basic. That style gives the cell a default text label accessible through the property textLabel.
        cell.textLabel?.text = gamesDataSource.gameName(at: indexPath) //default textLabel accessible through the property textLabel. It's not declared in code or added manually on the storyboard.
        //Add checkmark if this row is the selected game from the previous scene(Add Player)
        if indexPath.row == gamesDataSource.selectedGameIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //Executes whenever a cell in a table view is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Remove the gray selection background that appears by default on the row that has just been selected.
        tableView.deselectRow(at: indexPath, animated: true)
        //Get the previously selected game and remove the checkmark from its cell
        if let index = gamesDataSource.selectedGameIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        //Update data source to recognise this as the new selected game.
        gamesDataSource.selectGame(at: indexPath)
        //Mark the selected cell with a checkmark.
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        //The segue connects from the view controller itself(Choose Game Scene) so nothing else triggers it. We Control-drag from the View Controller icon to the Exit icon and give it the identifier 'unwind'. This way, we can reference it from the code here.
        //We do this since the alternative was creating an unwind segue from the table view cell to the Exit icon as we had done before. The problem with this was that this tableView function executed AFTER the action unwindWithSelectedGame which is found in PlayerDetailsViewController is executed. This is a problem because it means that by the time this executes, the unwind segue will have finished and will still be displaying the currently selected game in 'Add Player Scene'/PlayerDetailsViewController as the previous one, since it will be reading from the data source from before this function was executed. To fix this, you need to tell the view controller when to trigger the segue as we are doing below. So now, the unwindWithSelectedGame function executes after the code in this tableView function is complete and not before. So when we unwind back to the previous scene, the view in 'Add Player Scene' changes to the game we just selected.
        performSegue(withIdentifier: "unwind", sender: cell)
    }
}
