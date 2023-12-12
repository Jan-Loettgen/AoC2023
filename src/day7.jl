using DataStructures

global card_dict1 = Dict('A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T'=> 10, '9' => 9,
'8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2)

global card_dict2 = Dict('A' => 14, 'K' => 13, 'Q' => 12, 'J' => 1, 'T'=> 10, '9' => 9,
'8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2)

function extract_pairs1(hand)
    pairs = [0, 0]
    c_hand = counter(hand)

    score = 0
    for n in c_hand
        if n[2] == 5
            score = 7
        elseif n[2] == 4
            score = 6
        elseif n[2] == 3
            pairs[1] = 1
            score = 4
        elseif n[2] == 2 
            pairs[2] += 1
            score = 2
        end
    end

    if pairs[1] == 1 && pairs[2] == 1   # full house
        score = 5
    elseif  pairs[2] == 2               # two pair
        score = 3
    end

    return score
end


function extract_pairs2(hand)
    pairs = [0, 0]
    c_hand = counter(hand)

    n_j = 0
    if 'J' in keys(c_hand)
        n_j = c_hand['J']
    end

    score = 0
    for n in c_hand
        if n[1] == 'J'
            continue
        end

        if n[2] == 5
            score = 6
        elseif n[2] == 4
            score = 5
        elseif n[2] == 3
            pairs[1] = 1
            score = 3
        elseif n[2] == 2 
            pairs[2] += 1
            score = 1
        end
    end

    #full house
    if pairs[1] == 1 && pairs[2] == 1
        score = 4
    elseif  pairs[2] == 2
        score = 2
    end

    if n_j >0
        if n_j == 1
            if score == 2
                score = 4   # two pair -> full house
            elseif score == 3
                score = 5   # three of a kind -> four of a kind
            elseif score == 1
                score = 3
            else
                score = score + 1 # high card -> pair, pair -> three of a kind
            end
        
        elseif n_j == 2
            if score == 1   # pair -> four of a kind
                score = 5
            else
                score += 3
            end
        
        elseif n_j == 3
            if score == 0
                score = 5
            else 
                score = 6
            end
        elseif n_j == 4
            score = 6
        elseif n_j == 5
            score = 6
        end
    end
    return score
end

function compare_cards1(hand1, hand2)
    global card_dict1
    for i in range(1, 5)
        val1 = card_dict1[hand1[i]]
        val2 = card_dict1[hand2[i]]

        if val1 > val2
            return true
        elseif val1< val2
            return false
        end
    end
    return true
end

function compare_cards2(hand1, hand2)
    global card_dict2
    for i in range(1, 5)
        val1 = card_dict2[hand1[i]]
        val2 = card_dict2[hand2[i]]

        if val1 > val2
            return true
        elseif val1< val2
            return false
        end
    end
    return true
end


function compare_hands1(hand1, hand2)
    score1 = extract_pairs1(hand1[1])
    score2 = extract_pairs1(hand2[1])

    if score1 > score2
        return true
    elseif score1 < score2
        return false
    else
        return compare_cards1(hand1[1], hand2[1])
    end
end

function compare_hands2(hand1, hand2)
    score1 = extract_pairs2(hand1[1])
    score2 = extract_pairs2(hand2[1])

    if score1 > score2
        return true
    elseif score1 < score2
        return false
    else
        return compare_cards2(hand1[1], hand2[1])
    end
end

f = open("./inputs/day7.txt", "r")

lines = readlines(f)

net = DIct()
for (i,line) in enumerate(lines)

    if i == 1 
        instructions = split(readlines, "")
    else i >=3 

    
    end

end

sorted = sort!(hands_bids, lt = compare_hands1,rev=true)
sum = 0
for (i, hand_bid) in enumerate(sorted)
    global sum += i*hand_bid[2]
end
println(sum)

sorted = sort!(hands_bids, lt = compare_hands2,rev=true)
sum = 0
for (i, hand_bid) in enumerate(sorted)
    global sum += i*hand_bid[2]
end
println(sum)