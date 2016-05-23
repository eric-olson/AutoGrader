#include <gtest/gtest.h>
#include <string>
#include "vector.h"
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class input_t {
public:
	Vector<string> words;
	string from;
	string to;
};

void PrintTo(const input_t& v, ostream* os) {
	*os << "({";
	for (int i = 0; i < v.words.size(); i++) {
		*os << '"' << v.words[i] << '"';
		if (i < v.words.size() - 1) {
			*os << ", ";
		}
	}
	*os << "}, ";
	*os << '"' << v.from << '"' << ", ";
	*os << '"' << v.to << '"';
	*os << ")";
}

class CSCITest : public ::testing::TestWithParam<association<input_t,int>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, shortest(input.words, input.from, input.to));
}	


association<input_t,int> testvals[] = {
{{{"hen", "ten", "ton", "tin", "won", "win", "wit", "sit", "sat", "vat", "hit", "hot", "hut", "not", "pot", "pit", "pat", "cat", "car", "far", "tar", "bar", "bat", "bit", "bin", "sin", "pin", "pun", "pus", "bus", "but", "bun", "run", "ran", "can", "fan", "fin", "fir", "air", "aim", "rim"}, "wen", "pen"}, 3},
{{{"rain", "ruin", "gain", "grin", "grit", "main", "pain", "pair", "pail", "mail"}, "sail", "ruip"}, 6},
{{{"toast", "roast", "boast"}, "coast", "shore"}, 0},
{{{"pits", "fits", "sits", "bits", "hits", "pots", "pins", "pats", "puts", "pets", "pips", "site", "mite", "bite", "fite", "pine", "pate", "mile", "mole"}, "pith", "vole"}, 8},
{{{"hot", "dot", "dog"}, "hit", "cog"}, 5},
{{{"hot", "dot", "dog", "lot", "log"}, "hit", "cog"}, 5},
{{{"most", "mist", "fist", "fish"}, "lost", "cost"}, 3},
{{{"pits", "fits", "sits", "bits", "hits", "pots", "pins", "pats", "puts", "pets", "pips", "site", "mite", "bite", "fite", "hite", "pine", "pate", "mile", "mole", "pile"}, "pith", "vole"}, 8},
{{{"abcde", "abcda", "abcdb", "abcdc", "abcdd", "abcdf", "abcdg", "abcdh", "abcdi", "abcdj", "abcdk", "abcdm", "abcdn", "abcdo", "abcdp", "abcdq", "abcdr", "abcds", "abcdt", "abcdu", "abcdv", "ibcda", "ibcdb", "ibcdc", "ibcdd", "ibcdf", "ibcdg", "ibcdh", "ibcdi", "ibcdj", "ibcdk", "ibcdm", "ibcdn", "ibcdo", "ibcdp", "ibcdq", "ibcdr", "ibcds", "ibcdt", "ibcdu", "ibcdv", "ibcdy"}, "abode", "ibody"}, 6},
{{{"abcde", "abcda", "abcdb", "abcdc", "abcdd", "abcdf", "abcdg", "abcdh", "abcdi", "abcdj", "abcdk", "obcda", "obcdb", "obcdc", "obcdd", "obcdf", "obcdg", "obcdh", "obcdi", "obcdj", "obcdk", "obcdm", "obadm", "obbdm", "obddm", "obedm", "obfdm", "obgdm", "obhdm", "obidm", "objdm", "obkdm", "okadm", "okbdm", "okddm", "okedm", "okfdm", "okgdm", "okhdm", "okidm", "okjdm", "okkdm", "okodm", "okokm"}, "abode", "okoko"}, 10},
{{{"hot", "dog", "log"}, "hog", "hig"}, 0},
{{{"pit", "mit"}, "pot", "mot"}, 4},
{{{"pit", "mit", "mat"}, "pot", "mot"}, 4},
{{{"hot", "dot", "dog", "log", "dag", "lag", "lat", "dat"}, "hog", "dat"}, 4},
{{{"big", "bag", "beg", "bog", "lag", "leg", "log", "lug", "hug", "tug", "mug", "hut", "tut", "mut", "hum", "tum", "mum", "ham", "tam", "mam", "cam"}, "bit", "cat"}, 10},
{{{"care", "tart", "dart", "dare", "dirt"}, "cart", "dire"}, 4},
{{{"dire", "hire", "wire", "mire", "here", "were", "mere", "care", "tart", "dart", "dare", "dirt"}, "cart", "pere"}, 7}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

