import ballerina/io;

public type Player abstract object {

    string name;
    Card[] cards;

    public function play(SYMBOL? trump);
};

public type ComputerPlayer object {

    *Player;

    public function __init(string name) {
        self.name = name;
        self.cards = [];
    }

    public function play(SYMBOL? trump) {
        io:println("Player " + self.name + " turn...");

        Card[] trumpSet = [];
        Card[] nonTrumpSet = [];
        foreach Card card in self.cards {
            if (card.symbol == trump) {
                trumpSet.push(card);
            } else {
                nonTrumpSet.push(card);
            }
        }
        Card[] sortedTrumpSet = trumpSet.sort(function(Card c1, Card c2) returns int {
            return getCardNumericValue(c2.value) - getCardNumericValue(c1.value);
        });
        Card[] sortedNonTrumpSet = nonTrumpSet.sort(function(Card c1, Card c2) returns int {
            return getCardNumericValue(c2.value) - getCardNumericValue(c1.value);
        });

        io:print("Sorted trump set: ");
        printCards(sortedTrumpSet);
        io:print("Sorted non-trump set: ");
        printCards(sortedNonTrumpSet);

        Card selectedCard;
        if (sortedTrumpSet.length() > 0) {
            selectedCard = sortedTrumpSet.shift();
        } else {
            selectedCard = sortedNonTrumpSet.pop();
        }
        io:println("Player " + self.name + " choice: " + selectedCard.symbol.toString() + " " + selectedCard.value.toString());
    }
};

public type TerminalPlayer object {

    *Player;

    public function __init(string name) {
        self.name = name;
        self.cards = [];
    }

    public function play(SYMBOL? trump) {
        io:println("Your turn...");
        io:print("Your cards: ");
        printCards(self.cards);

        var cardIndex = ints:fromString(io:readln("Select a card (index starting from 1): "));
        if (cardIndex is int) {
            Card selectedCard = self.cards[cardIndex - 1];
            io:println("Your choice: " + selectedCard.symbol.toString() + " " + selectedCard.value.toString());
        } else {
            panic cardIndex;
        }
    }

    public function selectTrump() returns SYMBOL? {
        io:println("Selecting the Trump...");
        io:println("1. Hearts " + HEARTS);
        io:println("2. Clubs " + CLUBS);
        io:println("3. Diamonds " + DIAMONDS);
        io:println("4. Spades " + SPADES);
        var choice = ints:fromString(io:readln("Enter Trump Choice: "));
        if (choice is int) {
            if (choice >= 1 && choice <= 4) {
                match choice {
                    1 => return HEARTS;
                    2 => return CLUBS;
                    3 => return DIAMONDS;
                    4 => return SPADES;
                }
            } else {
                error e = error("Invalid Choice of Trump!");
                panic e;
            }
        } else {
            panic choice;
        }
        return ();
    }
};
