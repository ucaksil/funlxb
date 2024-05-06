def leastRepeatingCharacter(s):
    char_count = {}
    for char in s:
        if char in char_count:
            char_count[char] += 1
        else:
            char_count[char] = 1

    min_count = min(char_count.values())

    least_repeating_chars = [char for char, count in char_count.items() if count == min_count]

    print(char_count)

    return least_repeating_chars[0]

#Unit Test
input_str = "aaabbbcccdddeeefffg"
print(leastRepeatingCharacter(input_str))