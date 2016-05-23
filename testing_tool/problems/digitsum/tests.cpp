#include <gtest/gtest.h>
#include "assoc.h"

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<association<int,int>> {};

TEST_P(CSCITest, sum) {
	int input, output;
	input = GetParam().key;
	output = GetParam().value;
	EXPECT_EQ(output, digit_sum(input));
}	

association<int,int> testvals[] = {
	{0,0}, 
	{1,1},
	{123456,21},
	{1010101,4},
	{734610928,40}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

