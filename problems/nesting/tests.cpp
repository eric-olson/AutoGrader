#include <gtest/gtest.h>
#include <vector>
#include <string>
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<association<vector<string>,bool>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, is_valid(input[0], input[1], input[2]));
}	


association<vector<string>,bool> testvals[] = {
{{"", "", ""}, true},
{{"(easy)","(",")"}, true},
{{"abc(def)ghi","(",")"}, true},
{{"", "(", ")"}, true},
{{"hello!", "", ""}, true},
{{"(", "(", ")"}, false},
{{")", "(", ")"}, false},
{{")|(", "(", ")"}, false},
{{"(xyz", "(", ")"}, false},
{{"ab)c", "(", ")"}, false},
{{"(x(x)", "(", ")"}, false},
{{"(x))", "(", ")"}, false},
{{"abcdexEDCBA", "abcde", "ABCDE"}, true},
{{"([])", "([", ")]"}, true},
{{"(])]", "([", ")]"}, false},
{{"{x * [y * (z + <a,b>*<c,d>) - (e^k)] - phi}(_m_)", "([{<", ")]}>"}, true},
{{"{x * [y * (z + <a,b>*<c,d>) - (e^k)} - phi](_m_)", "([{<", ")]}>"}, false},
{{"{x * [y * (z + <a,b>*<c,d>) - (e^k)] - phi}(_m_'", "([{<", ")]}>"}, false}
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

