#include <gtest/gtest.h>
#include "vector.h"
#include "assoc.h"

using namespace std;

#include "solution.cpp"

class input_t {
public:
	Vector<int> arr;
	int amt;
};

void PrintTo(const input_t& v, ostream* os) {
	*os << "({" << v.arr << "}, " << v.amt << ")";
}

class CSCITest : public ::testing::TestWithParam<association<input_t,int>> {};

TEST_P(CSCITest, sum) {
	auto input = GetParam().key;
	auto output = GetParam().value;
	EXPECT_EQ(output, last_box(input.arr, input.amt));
}	


association<input_t,int> testvals[] = {
	{{{5, 8}, 3}, 1},
	{{{5, 8}, 4}, 0},
	{{{4, 9, 5}, 18}, 2},
	{{{13, 75, 24, 55}, 140}, 0},
	{{{14, 36, 52, 86, 27, 97, 3, 67}, 300}, 4},
	{{{1}, 1}, 0},
	{{{44, 63}, 30}, 0},
	{{{1, 9, 53}, 49}, 1},
	{{{57, 20, 12, 52}, 40}, 0},
	{{{6, 9, 94, 31, 67}, 147}, 4},
	{{{33, 18, 48, 73, 69, 81}, 118}, 4},
	{{{50, 93, 65, 70, 52, 28, 91}, 30}, 6},
	{{{36, 21, 45, 11, 63, 85, 64, 2}, 217}, 5},
	{{{37, 77, 32, 30, 98, 76, 92, 91, 45}, 555}, 3},
	{{{26, 30, 31, 28, 27, 44, 35, 5, 61, 50}, 108}, 0},
	{{{100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100}, 3198}, 47},
	{{{100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100}, 5000}, 49},
	{{{11, 6, 11, 1, 97, 43, 86, 61, 48, 25, 32, 59, 87, 20, 1, 16, 56, 83, 75, 62, 7, 3, 69, 66, 71, 19, 24, 90, 7, 20, 31, 56, 33, 94, 75, 96, 11, 74, 56, 31, 96, 46, 6, 95, 49, 74, 54, 75, 61, 42}, 387}, 48},
	{{{45, 44, 41, 38, 80, 36, 50, 30, 11, 8, 18, 56, 88, 74, 27, 46, 13, 73, 96, 54, 54, 84, 18, 56, 18, 77, 78, 77, 100, 55, 29, 3, 62, 56, 71, 17, 95, 82, 31, 81, 5, 87, 60, 8, 55, 80, 3, 66, 54, 33}, 842}, 15},
	{{{33, 64, 18, 8, 84, 11, 68, 17, 47, 20, 29, 72, 8, 57, 21, 54, 29, 55, 31, 78, 49, 21, 5, 15, 11, 20, 26, 99, 32, 2, 10, 52, 23, 18, 53, 25, 96, 72, 54, 26, 79, 17, 43, 98, 89, 33, 18, 5, 44, 96}, 965}, 4},
	{{{8, 37, 3, 68, 46, 64, 41, 99, 97, 52, 8, 68, 98, 79, 51, 10, 31, 61, 17, 62, 94, 10, 54, 99, 31, 35, 44, 90, 89, 32, 93, 2, 75, 95, 94, 66, 50, 66, 38, 59, 42, 49, 44, 30, 16, 90, 10, 89, 55, 44}, 142}, 45},
	{{{72, 17, 65, 78, 13, 6, 12, 13, 83, 93, 24, 2, 25, 5, 38, 3, 5, 64, 92, 74, 76, 7, 60, 27, 97, 60, 64, 59, 78, 85, 48, 57, 49, 6, 55, 95, 60, 31, 24, 84, 25, 48, 3, 48, 77, 50, 93, 89, 5, 34}, 1969}, 1},
	{{{43, 15, 68, 29, 7, 92, 1, 93, 19, 99, 19, 69, 76, 80, 20, 64, 97, 80, 17, 67, 41, 33, 31, 15, 56, 72, 12, 80, 97, 1, 17, 4, 94, 56, 29, 82, 6, 30, 38, 98, 87, 58, 78, 83, 55, 7, 58, 30, 81, 42}, 1245}, 33},
	{{{53, 34, 61, 91, 17, 33, 7, 15, 86, 48, 28, 36, 59, 84, 11, 43, 75, 5, 72, 73, 6, 81, 72, 80, 18, 82, 81, 92, 76, 1, 47, 33, 69, 59, 27, 79, 67, 69, 55, 4, 64, 23, 12, 94, 49, 58, 32, 20, 13, 93}, 2257}, 14},
	{{{21, 24, 39, 10, 53, 23, 29, 77, 53, 18, 24, 3, 5, 37, 51, 36, 26, 29, 65, 27, 66, 76, 5, 65, 74, 59, 25, 22, 30, 78, 25, 27, 5, 52, 38, 39, 26, 80, 20, 76, 89, 98, 21, 79, 67, 98, 56, 75, 29, 3}, 64}, 40},
	{{{80, 83, 77, 62, 28, 92, 83, 75, 62, 43, 98, 34, 6, 19, 76, 39, 21, 58, 40, 89, 72, 28, 57, 69, 65, 71, 80, 68, 39, 12, 7, 47, 79, 71, 11, 85, 43, 97, 9, 72, 69, 77, 8, 13, 49, 18, 58, 19, 55, 91}, 1342}, 25},
	{{{40, 50, 85, 12, 75, 22, 37, 29, 86, 94, 68, 44, 32, 55, 40, 84, 84, 85, 16, 97, 89, 35, 52, 23, 14, 90, 26, 86, 98, 77, 16, 50, 41, 14, 89, 23, 80, 83, 41, 67, 47, 1, 64, 23, 79, 46, 37, 58, 100, 86}, 1222}, 47},
	{{{18, 93, 33, 99, 32, 46, 85, 87, 36, 3, 5, 51, 78, 88, 96, 93, 79, 38, 88, 20, 16, 88, 58, 54, 54, 89, 84, 86, 76, 90, 10, 54, 96, 98, 70, 71, 69, 39, 99, 84, 45, 92, 1, 43, 54, 86, 3, 90, 46, 20}, 798}, 41},
	{{{45, 70, 43, 61, 98, 1, 78, 26, 84, 79, 51, 4, 95, 81, 60, 57, 27, 21, 76, 97, 49, 18, 9, 27, 46, 83, 35, 67, 37, 46, 5, 44, 26, 56, 70, 60, 24, 80, 83, 8, 40, 57, 24, 19, 36, 98, 54, 9, 70, 35}, 739}, 31},
	{{{21, 7, 15, 81, 71, 80, 63, 76, 72, 15, 45, 64, 27, 44, 76, 24, 58, 12, 19, 62, 73, 12, 67, 24, 40, 75, 11, 3, 23, 46, 23, 37, 34, 48, 35, 79, 12, 10, 14, 38, 18, 14, 51, 4, 70, 88, 92, 50, 56, 6}, 1495}, 22},
	{{{69, 30, 53, 12, 51, 71, 46, 92, 91, 75, 65, 18, 59, 54, 17, 75, 84, 17, 8, 9, 95, 57, 64, 91, 50, 96, 83, 7, 50, 24, 50, 54, 65, 40, 65, 3, 74, 44, 12, 60, 48, 70, 77, 53, 34, 5, 49, 90, 66, 11}, 111}, 23},
	{{{98, 67, 23, 84, 29, 81, 46, 96, 18, 50, 20, 27, 30, 79, 37, 84, 75, 49, 39, 7, 14, 93, 92, 20, 91, 17, 49, 64, 18, 18, 42, 49, 99, 87, 23, 8, 26, 95, 25, 48, 84, 19, 48, 91, 39, 65, 96, 42, 78, 18}, 1608}, 6},
	{{{16, 11, 26, 86, 15, 72, 7, 54, 41, 99, 45, 10, 6, 24, 78, 81, 81, 69, 59, 71, 97, 52, 44, 67, 39, 74, 32, 53, 35, 82, 63, 99, 2, 40, 99, 12, 85, 74, 59, 17, 44, 79, 75, 38, 30, 16, 72, 68, 58, 36}, 1688}, 13},
	{{{93, 49, 5, 92, 65, 79, 9, 56, 68, 74, 26, 2, 27, 66, 88, 100, 25, 17, 50, 11, 54, 24, 59, 54, 3, 56, 60, 7, 88, 58, 4, 83, 85, 88, 11, 43, 71, 62, 87, 2, 49, 98, 76, 42, 19, 81, 77, 16, 34, 55}, 2099}, 15},
	{{{56, 71, 93, 23, 54, 2, 24, 79, 91, 21, 43, 68, 53, 91, 83, 76, 60, 93, 73, 43, 12, 63, 95, 17, 76, 25, 85, 7, 80, 74, 8, 67, 67, 43, 78, 82, 75, 35, 87, 18, 93, 99, 49, 58, 54, 21, 15, 21, 12, 6}, 2292}, 10},
	{{{90, 79, 4, 18, 16, 56, 61, 6, 54, 55, 12, 40, 70, 32, 5, 35, 87, 36, 17, 46, 66, 28, 77, 35, 1, 80, 3, 60, 52, 71, 46, 54, 48, 52, 19, 14, 84, 62, 31, 21, 66, 80, 42, 76, 68, 44, 48, 58, 21, 97}, 1918}, 21},
	{{{47, 88, 48, 2, 70, 44, 33, 79, 48, 47, 36, 65, 48, 53, 10, 96, 28, 3, 22, 14, 91, 18, 37, 24, 87, 18, 52, 41, 28, 32, 87, 18, 26, 48, 19, 39, 30, 26, 100, 72, 90, 55, 81, 52, 33, 74, 40, 20, 11, 91}, 249}, 1},
	{{{63, 48, 55, 85, 18, 98, 18, 67, 37, 16, 48, 9, 18, 66, 62, 41, 71, 1, 1, 35, 36, 86, 78, 31, 82, 80, 24, 93, 63, 84, 39, 89, 19, 76, 57, 67, 29, 5, 32, 36, 88, 59, 95, 64, 93, 10, 51, 63, 50, 74}, 2610}, 49},
	{{{8, 9, 68, 79, 90, 95, 47, 92, 87, 81, 29, 35, 71, 61, 36, 86, 70, 96, 88, 27, 56, 32, 67, 11, 61, 32, 99, 94, 80, 91, 93, 82, 100, 28, 40, 43, 82, 93, 98, 78, 59, 42, 72, 11, 93, 41, 68, 100, 9, 20}, 3130}, 49},
	{{{11, 69, 57, 59, 88, 34, 69, 38, 33, 57, 13, 29, 24, 35, 79, 16, 39, 56, 3, 94, 9, 66, 2, 2, 67, 7, 59, 53, 81, 14, 64, 37, 35, 43, 79, 61, 21, 91, 77, 27, 4, 22, 70, 70, 15, 100, 4, 95, 39, 61}, 2278}, 49},
	{{{1, 52, 90, 12, 44, 64, 8, 58, 6, 41, 18, 91, 73, 45, 76, 42, 17, 11, 32, 50, 2, 1, 61, 62, 2, 61, 48, 2, 12, 12, 43, 53, 43, 17, 21, 65, 12, 82, 6, 95, 45, 52, 88, 12, 92, 95, 15, 20, 78, 76}, 2104}, 49},
	{{{78, 1, 87, 15, 82, 23, 73, 70, 98, 51, 17, 46, 23, 95, 64, 32, 51, 35, 5, 79, 68, 3, 31, 24, 77, 17, 26, 51, 38, 87, 98, 44, 55, 95, 50, 49, 26, 21, 45, 11, 7, 33, 12, 48, 44, 10, 83, 83, 47, 26}, 2334}, 49},
	{{{14, 36, 52, 86, 27, 97, 3, 67}, 300}, 4},
	{{{13, 75, 24, 55, 50, 50, 50, 50}, 299}, 3},
	{{{1, 2}, 3}, 1},
	{{{5, 8}, 3}, 1},
	{{{100, 100, 100, 100, 100}, 500}, 4},
	{{{100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99, 100, 99}, 4969}, 43},
	{{{5, 3, 6, 1, 9}, 4}, 2},
	{{{2, 2, 10}, 4}, 2},
	{{{5, 8}, 4}, 0},
	{{{5, 5}, 2}, 1},
};
	
INSTANTIATE_TEST_CASE_P(inputs, CSCITest, ::testing::ValuesIn(testvals));

