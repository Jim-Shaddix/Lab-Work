
"""
    find the longest continuous substring
    - were you are allowed to remove elements
      in-between elements that contained in the s
      substring
"""

def longest_substring(s1, s2):

    # Base Cases:
    if len(s1) == 0 or len(s2) == 0:
        return ''

    """
        Thoughts:
        * do not change s1
        CASE len(s2) == 1: 
            - just check if s2 is in s1
        CASE len(s2) == 2:
            - check if s2[0] in s1, and 
              that its poition in s1 comes before the position of s2[1] in s1
    """

if __name__ == '__main__':

    s1 = "abcd"
    s2 = "ab00"
    s = longest_substring(s1, s2)

    print("s1:", s1)
    print("s2:", s2)
    print("Longest substring of s1 and s2:")
    print(s)
