import ballerina/io;
import ballerina/math;
import ballerina/lang.'int as ints;

public type Game object {

    Player[] players = [];
    Card[] cards = [];
    SYMBOL? trump = ();

    public function __init() {
        SYMBOL[] symbols = [HEARTS, CLUBS, DIAMONDS, SPADES];
        VALUE[] values = [VALUE_A, VALUE_K, VALUE_Q, VALUE_J, VALUE_10, VALUE_9, VALUE_8, VALUE_7];

        foreach SYMBOL symbol in symbols {
            foreach VALUE value in values {
                Card card = new(symbol, value);
                self.cards.push(card);
            }
        }
    }

    public function addPlayer(Player p) {
        // todo: validate max count
        self.players.push(p);
    }

    public function distributeCards() returns error? {
        foreach int iteration in 0...self.cards.length() - 1 {
            int randomVal = check math:randomInRange(0, self.cards.length());
            Card randomCard = self.cards.remove(randomVal);
            self.players[iteration % 4].cards[iteration / 4] = randomCard;
        }
    }

    public function startGame() returns error? {
        TerminalPlayer terminalPlayer = <TerminalPlayer>self.players[0];
        self.trump = terminalPlayer.selectTrump();


        while (terminalPlayer.cards.length() > 0) {
            Player maxPlayer = terminalPlayer;
            int maxScore = 0;
            foreach Player p in self.players {
                Card selectedCard = p.play(self.trump);
                if (selectedCard.symbol == self.trump) {
                    int currentScore = getCardNumericValue(selectedCard.value);
                    if (maxScore < currentScore) {
                        maxPlayer = p;
                        maxScore = currentScore;
                    }
                }
            }
            maxPlayer.score += 1;
        }
    }
};

public function printCards(Card[] cards) {
    foreach Card card in cards {
        io:print(card.symbol.toString() + " " + card.value.toString() + ", ");
    }
    io:println();
}

function getCardNumericValue(VALUE value) returns int {
    match value {
        VALUE_7 => return 7;
        VALUE_8 => return 8;
        VALUE_9 => return 9;
        VALUE_10 => return 10;
        VALUE_J => return 11;
        VALUE_Q => return 12;
        VALUE_K => return 13;
        VALUE_A => return 14;
    }
    return -1;
}
