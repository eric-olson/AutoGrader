#include <gtest/gtest.h>
#include <string>
#include "vector.h"
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class input_t {
public:
	Vector<string> bracket;
	string results;
};

void PrintTo(const input_t& v, ostream* os) {
	*os << "({";
	for (int i = 0; i < v.bracket.size(); i++) {
		*os << '"' << v.bracket[i] << '"';
		if (i < v.bracket.size()-1) {
			*os << ',';
		}
	}
	*os << "}, \"" << v.results << "\")";
}

class CSCITest : public ::testing::TestWithParam<association<input_t,string>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, winner(input.bracket, input.results));
}	

association<input_t,string> testvals[] = {
{{{"DUKE", "UCLA", "bye", "MIT"}, "HL"}, "MIT"},
{{{"A", "B", "C", "bye", "D", "E", "F", "bye"}, "LHHLH"}, "B"},
{{{"A", "B", "A", "C", "X", "bye", "bye", "D", "E", "F", "G", "H", "I", "J", "K", "L"}, "HLHLHLHLHLHLH"}, "A"},
{{{"A", "B", "A", "C", "X", "bye", "bye", "D", "E", "F", "G", "H", "I", "J", "K", "L"}, "HHHHHHHHHHHHH"}, "A"},
{{{"A", "B", "A", "C", "X", "bye", "bye", "D", "E", "F", "G", "H", "I", "J", "K", "L"}, "LHHLLHHLHLLLH"}, "D"},
{{{"MIT", "bye"}, ""}, "MIT"},
{{{"A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "A", "bye", "X", "bye"}, "LLLLLLLLLLLLLLL"}, "X"},
{{{"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "HARVARD", "A", "B", "C", "D", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "HARVARD", "A", "B", "C", "D"}, "LLLLLLLLLLLLLLLLLLLLLLLLHHHHLLL"}, "HARVARD"},
{{{"ABLE", "BUTTER", "CHALK", "bye", "bye", "NORTHERN", "X", "bye"}, "HLHL"}, "NORTHERN"},
{{{"bye", "ABCDEFGHIJKLM"}, ""}, "ABCDEFGHIJKLM"},
{{{"WELL", "bye", "bye", "MISS", "AMERICAN", "PIE", "bye", "CHEVY"}, "HHHH"}, "WELL"},
{{{"ONE", "TWO", "THREE", "FOUR"}, "LHL"}, "THREE"},
{{{"A", "B", "A", "C", "X", "bye", "bye", "D", "E", "F", "G", "H", "I", "J", "K", "L"}, "LHHLLHHHHHLLH"}, "X"},
{{{"STANFORD", "bye", "STANFORD", "bye"}, "L"}, "STANFORD"},
{{{"AUGUSTANA", "DORDT"}, "H"}, "AUGUSTANA"},
{{{"AUGUSTANA", "DORDT"}, "L"}, "DORDT"},
{{{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "AA", "AB", "AC", "AD", "AE", "AF"}, "LHLHLHHLHLLHLLLHLHHLHHLHLHHHHHL"}, "Q"},
{{{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "AA", "AB", "AC", "AD", "AE", "AF"}, "LHHHHLHLHLLHHLHLHHLHLLLLLLLLHLH"}, "E"},
{{{"bye", "MIT"}, ""}, "MIT"},
{{{"A", "B", "C", "bye"}, "LH"}, "B"},
{{{"DUKE", "BYE", "bye", "MIT"}, "HL"}, "MIT"},
{{{"OIEJ", "PIERJPEIOWJ", "WOEIJFDS", "PWEJIOWE", "PWEOIJFEW", "OPFEJWPIOJE", "PEWFIOJPEFWJ", "PIEWURPWOWEPEOWIR", "PWEOIJUFDPSJ", "PWEORPEWOJ", "PEWOJPOEWJ", "OPWEIUJDPJV", "PWOIJEPOWEJ", "POIJEWTPWEJ", "PWEOITJPEWOIJTP", "WPOEITHJPEWTOJ"}, "LLLLLLLLLLLLLLL"}, "WPOEITHJPEWTOJ"},
{{{"bye", "A"}, ""}, "A"},
{{{"bye", "X"}, ""}, "X"}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

