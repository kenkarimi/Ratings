//
//  PlayerDetailsViewCotroller.swift
//  Ratings
//
//  Created by Kennedy Karimi on 20/06/2022.
//

import UIKit
// "Add Player Scene"
class PlayerDetailsViewController: UITableViewController {
    var player: Player?
    
    //This will save the name of the game. Any time this property value is updated, the label will also be updated.
    var game = "" {
        didSet {
            detailLabel.text = game //Initially empty but when viewDidLoad() executes, it'll be updated again.
        }
    }
    //NB: Previously, when we attached outlets/created relatioships to the Players Scene connections inspector(The 2 labels and 1 image view), we had to create a class called PlayerCell where we created IBOutlets in because you can’t attach outlets in a view controller to views in dynamic cells(Table View in Players Scene is a dynamic prototype). Those cells won’t be displayed when the view controller is initialized. But for static cells(like this one in Add Player Scene), everything is set in the storyboard(meaning the data is static when the view controller is initialized), so you can safely attach views inside static cells to outlets in the view controller.
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    
    //Storyboards don’t have any impact on app performance. Only the view controller we’re showing will be loaded, and it will be released when dismissed.
    //To test this, this tracks PlayerDetailsViewController initialization and deinitialization by printing some text in the log.
    required init?(coder aDecoder: NSCoder) {
      print("init PlayerDetailsViewController")
      super.init(coder: aDecoder)
    }

    deinit {
      print("deinit PlayerDetailsViewController")
    }
    
    //The view controller will call viewDidLoad() once when it loads all its views in memory. Since updating the game value will update the view, it makes sense to do this when the views finished loading.
    override func viewDidLoad() {
        game = "Chess"
        nameTextField.becomeFirstResponder() //Text field is auto focused and ready to type as soon as the view loads so we don't have to click on it.  Press Command-K to toggle the software keyboard on & off in the simulator.
    }
    
    //Passing parameters with segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //This is an unwind segue. It's IBAction is in PlayersViewController.
        //In this case, with the 'Done' button unwind segue that goes from Add Player Scene(PlayerDetailsViewController) to Player Scene(PlayersViewController)
        //To do this, we first add an identifier called 'SavePlayerDetail' in the storyboard to the relationship segue that goes from the 'Done' button to the Exit icon.
        if segue.identifier == "SavePlayerDetail", let playerName = nameTextField.text, let gameName = detailLabel.text {
            player = Player(name: playerName, game: gameName, rating: 1)
        }
        //This is NOT an unwind segue.
        //In this case, with the segue that goes from Add Player Scene(PlayerDetailsViewController) to Choose Game Scene(GamePickerViewController) when the detail label is clicked.
        //To do this, we first add an identifier called 'PickGame' in the storyboard to the relationship segue that goes from Add Player to Choose Game, same as we did with Table view Cell.
        if segue.identifier == "PickGame", let gamePickerViewController = segue.destination as? GamePickerViewController {
            gamePickerViewController.gamesDataSource.selectedGame = game
        }
    }
    
    //exit segue to the view controller it is implemented on. Unwinds whenever a new game is selected in Choose Game Scene(GamePickerViewController)
    @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue){ //Unlike the cancel & done navbar segues this one doesn't have the underscore before the 'segue:'. Honestly not sure why since non of these methods are callable from code. They all execute when the actions happen on the screen.
        
        //Update the name of the game in this Add Player Scene to the one that was just selected in the scene we unwinded from (Choose Game Scene/GamePickerViewController)
        if let gamePickerViewController = segue.source as? GamePickerViewController, let selectedGame = gamePickerViewController.gamesDataSource.selectedGame {
            game = selectedGame
        }
    }
}
