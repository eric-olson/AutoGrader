#include <gtest/gtest.h>
#include <string>
#include "assoc.h"

using ::std::string;

#include "solution.cpp"


class CSCITest : public ::testing::TestWithParam<association<string, double>> {};

TEST_P(CSCITest, sum) {
	string input;
	double output;
	input = GetParam().key;
	output = GetParam().value;
	EXPECT_NEAR(output, ratio(input), 1e-6);
}	

association<string,double> testvals[] = {
	{"cgcgcgcg", 1.0},
	{"aaaaaaaa", 0.0},
	{"cgaacgaa", 0.5},
	{"ccccccccccccccccca", 0.9444444444444444},
	{"cccccccccccccccccttttt", 0.7727272727272727},
	{"cttttttttttttttttttttt", 0.045454545454545456},
	{"ctttttttttttttttttttttttttttttttttttttttttttttttt", 0.02040816326530612}, 
	{"cgcgcgcgtttttttttttttttttttttttttttttttttttttttttt", 0.16}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

