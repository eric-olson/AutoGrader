#include <gtest/gtest.h>
#include <string>
#include <vector>
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<association<vector<string>,int>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, count(input[0], input[1]));
}	


association<vector<string>,int> testvals[] = {
	{{"horse","mirth"}, 2},
	{{"horse","moose"}, 3},
	{{"horse","short"}, 4},
	{{"horse","seems"}, 2},
	{{"horse","esroh"}, 5},
	{{"horse","house"}, 4},
	{{"spear","pears"}, 5},
	{{"toots","stout"}, 4},
	{{"sassy","assay"}, 4},
	{{"sassy","stork"}, 1},
	{{"fruit","snack"}, 0},
	{{"ooxxo","xxooo"}, 5},
	{{"abcde","fghij"}, 0}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

