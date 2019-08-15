import ballerina/io;

//public const string HEARTS = "Hearts ♥";
//public const string CLUBS = "Clubs ♣";
//public const string DIAMONDS = "Diamonds ♦";
//public const string SPADES = "Spades ♠";

public const string HEARTS = "♥";
public const string CLUBS = "♣";
public const string DIAMONDS = "♦";
public const string SPADES = "♠";

public const string VALUE_A = "A";
public const string VALUE_K = "K";
public const string VALUE_Q = "Q";
public const string VALUE_J = "J";
public const string VALUE_10 = "10";
public const string VALUE_9 = "9";
public const string VALUE_8 = "8";
public const string VALUE_7 = "7";

public type SYMBOL HEARTS|CLUBS|DIAMONDS|SPADES;
public type VALUE VALUE_A|VALUE_K|VALUE_Q|VALUE_J|VALUE_10|VALUE_9|VALUE_8|VALUE_7;

public type Card object {

    SYMBOL symbol;
    VALUE value;

    public function __init(SYMBOL symbol, VALUE value) {
        self.symbol = symbol;
        self.value = value;
    }
};
