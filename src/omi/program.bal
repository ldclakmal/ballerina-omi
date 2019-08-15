import ballerina/io;
import ballerina/lang.'int as ints;

public function main() returns error? {
    io:println("--- Welcome to OMI ---");
    io:println("Initializing the game...");

    Player p1 = new TerminalPlayer("P1");
    Player p2 = new ComputerPlayer("P2");
    Player p3 = new ComputerPlayer("P3");
    Player p4 = new ComputerPlayer("P4");

    Game game = new;

    game.addPlayer(p1);
    game.addPlayer(p2);
    game.addPlayer(p3);
    game.addPlayer(p4);

    io:println("You are player P1...");

    io:print("Card Pack: ");
    printCards(game.cards);

    var result = game.distributeCards();
    // todo: update for distribution of cards in 2 iterations: before declaring the trump and after declaring the trump

    // todo: comment followings after completion
    foreach Player p in game.players {
        io:print("Cards of " + p.name + " : ");
        printCards(p.cards);
    }

    io:println("----------------------------------------------------------------------------------------------------");
    io:println("Starting the game...");
    result = game.startGame();
}
