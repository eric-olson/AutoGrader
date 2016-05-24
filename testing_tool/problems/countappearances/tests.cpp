#include <gtest/gtest.h>
#include <utility>
#include "assoc.h"

#include "solution.cpp"

using ::std::pair;

class CSCITest : public ::testing::TestWithParam<association<pair<int,int>,int>> {};

TEST_P(CSCITest, sum) {
	pair<int,int> input;
	int output;
	input = GetParam().key;
	output = GetParam().value;
	EXPECT_EQ(output, number_times_appear(input.first, input.second));
}	

association<pair<int,int>,int> testvals[] = {
	{{1,1},1},
	{{23,2},1},
	{{5847348,7},1},
	{{222,2},3},
	{{123456,7},0},
	{{123456,4},1},
	{{5847348,4},2},
	{{5847348,8},2},
	{{555555,5},6}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

