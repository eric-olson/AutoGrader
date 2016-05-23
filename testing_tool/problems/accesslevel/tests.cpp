#include <gtest/gtest.h>
#include <string>
#include "vector.h"
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class input_t {
public:
	Vector<int> arr;
	int level;
};

void PrintTo(const input_t& v, ostream* os) {
	*os << "(" << v.arr << ", " << v.level << ")";
}

class CSCITest : public ::testing::TestWithParam<association<input_t,string>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, can_access(input.arr, input.level));
}	

association<input_t,string> testvals[] = {
	{{{0,1,2,3,4,5},2},"DDAAAA"},
	{{{5, 3, 2, 10, 0},20}, "DDDDD"},
	{{{},20}, ""},
	{{{34, 78, 9, 52, 11, 1},49}, "DADADD"},
	{{{1,1,1,1,1,1,1,1,1,1,1,1,1},1}, "AAAAAAAAAAAAA"},
	{{{99,99,99,99,99,1,2,3,4,5},50}, "AAAAADDDDD"},
	{{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50},25}, "DDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAAAAAAAAAAA"},
	{{{99,98,97,96,95,34,33,32,31,1,2,3,4,5},0}, "AAAAAAAAAAAAAA"},
	{{{99,98,97,96,95,34,33,32,31,1,2,3,4,5},4}, "AAAAAAAAADDDAA"},
	{{{1, 2, 3, 4, 5},2}, "DAAAA"} 
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

