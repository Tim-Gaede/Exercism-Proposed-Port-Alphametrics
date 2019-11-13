using Combinatorics

function solve(puzzle)
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    words = String[]
    word = ""
    for char in puzzle
        if char ∈ alphabet
            word *= char
        else
            if length(word) > 0;    push!(words, word);    end
            word = ""
        end
    end

    push!(words, word)

    letters_used = ""
    for word in words
        for letter in word
            if letter ∉ letters_used;    letters_used *= letter;    end
        end
    end


     
    digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    combis = combinations(digits, length(letters_used))
    for combi in combis
        permus = permutations(combi)
        for permu in permus
            digit_from_letter = Dict{Char, Int64}()
            for i = 1 : length(permu)
                digit_from_letter[letters_used[i]] = permu[i]
            end
            nums = Int64[]
            leading_zero_found = false
            i = 1
            while !leading_zero_found &&  i ≤ length(words)
                if digit_from_letter[words[i][1]] == 0
                    leading_zero_found = true
                else
                    num = 0
                    for j = 1 : length(words[i])
                        expo = length(words[i]) - j
                        digit = digit_from_letter[words[i][j]]
                        num += digit * 10^expo
                    end
                    push!(nums, num)
                end
                i += 1
            end

            if !leading_zero_found  &&  sum(nums) - last(nums) == last(nums)
                return digit_from_letter
            end
        end
    end

    return nothing
end
