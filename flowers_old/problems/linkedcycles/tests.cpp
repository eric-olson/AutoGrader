#include <gtest/gtest.h>
#include <string>
#include <vector>
#include "assoc.h"
#include <map>

using namespace std;

class node {
public:
	node() { next = NULL; }
	node* next;
};

node* vector_to_list(const vector<int> &vec) {
	vector<node*> scaffold(vec.size());
	for (int i = 0; i < scaffold.size(); i++) {
		scaffold[i] = new node;
	}
	for (int i = 0; i < vec.size(); i++) {
		if (vec[i] != -1) scaffold[i]->next = scaffold[vec[i]];
	}
	return scaffold[0];
}

int clength(node* head) {
	int i = 0;
	node* p = head;
	map<node*, int> m;
	while (p->next != NULL) {
		m[p] = i;	
		if (m.find(p->next) != m.end()) {
			return 1 + i - m[p->next];
		}
		p = p->next;
		i++;
	}
	return -1;
}

class input_t {
public:
	vector<int> v;
};

void PrintTo(const input_t& input, ostream* os) {
	vector<int> v = input.v;
	*os << "0";
	for (int i = 0; i < v.size(); i++) {
		if (v[i] == -1) {
			*os << "->NULL";
			break;
		}
		else {
			*os << "->" << v[i];
		}
	}
	// needed to get output showing via my xslt
	*os << ":";
}

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<input_t> {};

TEST_P(CSCITest, sum) {
	vector<int> vec = GetParam().v;
	node* input = vector_to_list(vec);
	int output = clength(input);
	EXPECT_EQ(output, cycle_length(input));
}	

input_t testvals[] = {
	{{1,2,3,-1}},
	{{1,2,3,0}},
	{{0}},
	{{1,2,3,4,5,6,7,8,9,10,-1}},
	{{1,2,3,4,5,6,7,8,9,4}},
	{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,15}},
	{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,2}},
	{{1,2,3,4,5,6,7,8,-1}},
	{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,1}},
	{{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,5}}
};

	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

