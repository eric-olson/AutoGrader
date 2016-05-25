#include <gtest/gtest.h>
#include <string>
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<association<string,string>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, encrypt(input));
}	


association<string,string> testvals[] = {
{"hello", "abccd"},
{"abcd", "abcd"},
{"topcoder", "abcdbefg"},
{"encryption", "abcdefghib"},
{"adwuaaxcnleegluqvsczaguujoppchwecusmevz", "abcdaaefghiijhdklmfnajddopqqfrcifdmsiln"},
{"ykquacpkggiianyoolwgykymwraiyigfuxagvwxfkcemiix", "abcdefgbhhiiejakklmhabanmoeiaihpdqehrmqpbfsniiq"},
{"amyulokgckc", "abcdefghigi"},
{"aaaabbbaaa", "aaaabbbaaa"},
{"aaaaaabab", "aaaaaabab"},
{"abaaabbaa", "abaaabbaa"},
{"aaaaaaa", "aaaaaaa"},
{"baaaaaa", "abbbbbb"},
{"abbaaaaba", "abbaaaaba"},
{"baaabaaaa", "abbbabbbb"},
{"bbbbbaa", "aaaaabb"},
{"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
{"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
{"zzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
{"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
{"iiiijllkiikiikkkijkjkiliikllkiiiiikkik", "aaaabccdaadaadddabdbdacaadccdaaaaaddad"},
{"liiiiikkijlkikk", "abbbbbccbdacbcc"},
{"ikjiiijkiiiijlll", "abcaaacbaaaacddd"},
{"kiiiiikkiiliiiii", "abbbbbaabbcbbbbb"},
{"kliijiilkkijiikiiklljkiiikkjiikkkiiiiiilkik", "abccdccbaacdccaccabbdacccaadccaaaccccccbaca"},
{"ouswtvpoqsusuoqwwroruqpswsrrqoowoqooousvuouwuwuuxt", "abcdefgahcbcbahddiaibhgcdciihaadahaaabcfbabdbdbbje"},
{"oqwtwopsoutoqosovxxxtqwqosooowstououqqsvsoxssvoqst", "abcdcaefagdabafahiiidbcbafaaacfdagagbbfhfaiffhabfd"},
{"ssquwtxpqosowqrsuqowouwowqtwswqxqwoovwxtoowxsuxsut", "aabcdefgbhahdbiacbhdhcdhdbedadbfbdhhjdfehhdfacface"},
{"qosvsrrstqouosuwttuowwqsqxowuwqotwwstwowuuwoxuosoo", "abcdceecfabgbcghffgbhhacaibhghabfhhcfhbhgghbigbcbb"},
{"wtquputtsqooqotoqoootsuussqwooooqsuqtwtqoswvtoqopv", "abcdedbbfcggcgbgcgggbfddffcaggggcfdcbabcgfahbgcgeh"},
{"vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
{"a", "a"},
{"ffffgggffffffffffgfgffgfffggfffffffffffgfffffff", "aaaabbbaaaaaaaaaababaabaaabbaaaaaaaaaaabaaaaaaa"},
{"ghdytsrsrtstrggg", "abcdefgfgefegaaa"},
{"qwerewrewrere", "abcdcbdcbdcdc"},
{"zabjhkaskbjbkzzxcjkayyasdhkas", "abcdefbgfcdcfaahidfbjjbgkefbg"},
{"zxcvbnmlkjhgfhjtuiknvdwrtuiknfdfdsaqwertyuiop", "abcdefghijklmkjnopifdqrsnopifmqmqtuvrwsnxopyz"},
{"asdasdlasdjsdgjskdgsdfsfsdfs", "abcabcdabcebcfebgcfbchbhbchb"},
{"bbbbbbbbaaaaaaccccc", "aaaaaaaabbbbbbccccc"},
{"aa", "aa"},
{"aaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbb", "aaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbb"},
{"aaz", "aab"},
{"ddffgggghhggddhtyn", "aabbccccddccaadefg"},
{"aaaabbbcdbzzadbdbejkghgjeghggeppozhfadzzsaabd", "aaaabbbcdbeeadbdbfghijigfijiifkklejmadeenaabd"},
{"rjatydimofugclqurclqecdrhvqsuwbvntmryktdl", "abcdefghijklmnokamnopmfaqroskturvdhaewdfn"},
{"blahblahmammamia", "abcdabcdeceecefc"},
{"ziang", "abcde"},
{"abaaba", "abaaba"},
{"pubaba", "abcdcd"},
{"z", "a"},
{"bbd", "aab"},
{"aaabbbbbaaaaab", "aaabbbbbaaaaab"}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

