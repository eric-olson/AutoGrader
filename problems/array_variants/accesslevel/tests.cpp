#include <gtest/gtest.h>
#include <string>
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class input_t {
public:
	int* arr;
	size_t sz;
	int level;
};

void PrintTo(const input_t& v, ostream* os) {
	*os << "({";
	for (int i = 0; i < v.sz; i++) {
		*os << v.arr[i];
		if (i < v.sz-1) {
			*os << ',';
		}
	}
	*os << "}, " << v.sz << ", " << v.level << ")";
}

class CSCITest : public ::testing::TestWithParam<association<input_t,string>> {};

TEST_P(CSCITest, sum) {
	auto in = GetParam().key;
	auto out = GetParam().value;
	int* user_rights = in.arr;
	size_t user_count = in.sz;
	int min_permission = in.level;
	EXPECT_EQ(out, can_access(user_rights, user_count, min_permission));
}	

int a0[] = {0,1,2,3,4,5};
int a1[] = {5, 3, 2, 10, 0};
int* a2 = NULL;
int a3[] = {34, 78, 9, 52, 11, 1};
int a4[] = {1,1,1,1,1,1,1,1,1,1,1,1,1};
int a5[] = {99,99,99,99,99,1,2,3,4,5};
int a6[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50};
int a7[] = {99,98,97,96,95,34,33,32,31,1,2,3,4,5};
int a8[] = {99,98,97,96,95,34,33,32,31,1,2,3,4,5};
int a9[] = {1, 2, 3, 4, 5};

association<input_t,string> testvals[] = {
	{{a0,6,2},"DDAAAA"},
	{{a1,5,20}, "DDDDD"},
	{{a2,0,20}, ""},
	{{a3,6,49}, "DADADD"},
	{{a4,13,1}, "AAAAAAAAAAAAA"},
	{{a5,10,50}, "AAAAADDDDD"},
	{{a6,50,25}, "DDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAAAAAAAAAAA"},
	{{a7,14,0}, "AAAAAAAAAAAAAA"},
	{{a8,14,4}, "AAAAAAAAADDDAA"},
	{{a9,5,2}, "DAAAA"}, 
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

