import ballerina/io;

public type Player abstract object {

    string name;
    Card[] cards;
    int score;

    public function play(SYMBOL? trump) returns Card;
};

public type ComputerPlayer object {

    *Player;

    public function __init(string name) {
        self.name = name;
        self.cards = [];
        self.score = 0;
    }

    public function play(SYMBOL? trump) returns Card {
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

        //io:print("Sorted trump set: ");
        //printCards(sortedTrumpSet);
        //io:print("Sorted non-trump set: ");
        //printCards(sortedNonTrumpSet);

        Card selectedCard;
        if (sortedTrumpSet.length() > 0) {
            selectedCard = sortedTrumpSet.shift();
        } else {
            selectedCard = sortedNonTrumpSet.pop();
        }

        int index = 0;
        foreach Card card in self.cards {
            if (card.symbol == selectedCard.symbol && card.value == selectedCard.value) {
                break;
            }
            index += 1;
        }
        _ = self.cards.remove(index);

        io:println("Player " + self.name + " choice: " + selectedCard.symbol.toString() + " " + selectedCard.value.toString());
        return selectedCard;
    }
};

public type TerminalPlayer object {

    *Player;

    public function __init(string name) {
        self.name = name;
        self.cards = [];
        self.score = 0;
    }

    public function play(SYMBOL? trump) returns Card {
        io:println();
        io:print("Your cards: ");
        printCards(self.cards);

        var cardIndex = ints:fromString(io:readln("Select a card (index starting from 1): "));
        if (cardIndex is int) {
            if (cardIndex <= 1 && cardIndex > self.cards.length()) {
                error e = error("Invalid input for the card!");
                panic e;
            }
            Card selectedCard = <@untainted> self.cards.remove(cardIndex - 1);
            io:println("Your choice: " + selectedCard.symbol.toString() + " " + selectedCard.value.toString());
            return selectedCard;
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
