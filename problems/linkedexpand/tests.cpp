#include <gtest/gtest.h>
#include <string>
#include <vector>
#include "assoc.h"
#include <map>

using namespace std;

class node {
public:
	node() { data = ""; next = NULL; }
        string data;
	node* next;
};

node* vector_to_list(const vector<string> &vec) {
	vector<node*> scaffold(vec.size());
	for (int i = 0; i < scaffold.size(); i++) {
		scaffold[i] = new node;
		scaffold[i]->data = vec[i];
	}
	for (int i = 0; i < vec.size()-1; i++) {
		scaffold[i]->next = scaffold[i+1];
	}
	return scaffold[0];
}

vector<string> list_to_vector(node* head) {
	vector<string> ans;
	while (head != NULL) {
		ans.push_back(head->data);
		head = head->next;
	}
	return ans;
}

class input_t {
public:
	vector<string> v;
};

void PrintTo(const input_t& input, ostream* os) {
	vector<string> v = input.v;
	for (int i = 0; i < v.size(); i++) {
		*os << v[i] << "->";
	}
	*os << "NULL";
}

#include "solution.cpp"

class CSCITest : public ::testing::TestWithParam<association<input_t,input_t>> {};

TEST_P(CSCITest, sum) {
	vector<string> vec = GetParam().key.v;
	node* input = vector_to_list(vec);
	vector<string> output = GetParam().value.v;
	EXPECT_EQ(output, list_to_vector(expand(input)));
}	

association<input_t,input_t> testvals[] = {
	{{{"apple"}},{{"apple","apple"}}},
	{{{"apple","apple"}},{{"apple","apple"}}},
	{{{"apple","orange"}},{{"apple","apple","orange","orange"}}},
	{{{"apple","apple","orange"}},{{"apple","apple","orange","orange"}}},
	{{{"foo","foo","foo"}},{{"foo","foo","foo"}}},
	{{{"foo","foo","foo","bar","baz","baz"}},{{"foo","foo","foo","bar","bar","baz","baz"}}},
	{{{"green","green","green","blue","blue","blue","blue","red","red","red"}},{{"green","green","green","blue","blue","blue","blue","red","red","red"}}},
	{{{"green","green","blue","red","green"}},{{"green","green","blue","blue","red","red","green","green"}}},
	{{{"green","green","blue","blue","blue","red","green","green","green"}},{{"green","green","blue","blue","blue","red","red","green","green","green"}}},
	{{{"cat","dog","dog","dog","dog","fish","fish","cat","cat","dog","dog","fish"}},{{"cat","cat","dog","dog","dog","dog","fish","fish","cat","cat","dog","dog","fish","fish"}}}
};

	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

