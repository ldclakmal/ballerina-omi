import ballerina/io;

public function main() returns error? {
    io:println("--- Welcome to OMI ---");

    Player p1 = new TerminalPlayer("P1");
    Player p2 = new ComputerPlayer("P2");
    Player p3 = new ComputerPlayer("P3");
    Player p4 = new ComputerPlayer("P4");

    Game game = new;

    game.addPlayer(p1);
    game.addPlayer(p2);
    game.addPlayer(p3);
    game.addPlayer(p4);

    io:println("- YOU ARE PLAYER P1 -");

    // For DEBUG purpose only.
    //io:print("Card Pack: ");
    //printCards(game.cards);

    var result = game.distributeCards();

    // For DEBUG purpose only.
    //foreach Player p in game.players {
    //    io:print("Cards of " + p.name + " : ");
    //    printCards(p.cards);
    //}

    game.startGame();
    game.printScore();
}
