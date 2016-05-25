#include <gtest/gtest.h>
#include <string>

#include "newtracker.cpp"

using namespace std;

#define main student_main
#include "solution.cpp"

TEST(CSCITest, allocate_int1) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    int* p = allocate_int();
    size_t num_allocated  = _newtracker_count() - before;
    size_t size_allocated = _newtracker_getsize(p);
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(1, num_allocated) << "allocate_int(): nothing appears to have been allocated, or it was already deallocated, or too many items were allocated";
    EXPECT_EQ(sizeof(int), size_allocated) << "allocate_int(): pointer does not appear to point to a single dynamically allocated int";

    delete p;
}

TEST(CSCITest, allocate_int2) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    int* p = allocate_int(42);
    size_t num_allocated  = _newtracker_count() - before;
    size_t size_allocated = _newtracker_getsize(p);
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(1, num_allocated) << "allocate_int(int): nothing appears to have been allocated, or it was already deallocated, or too many items were allocated";
    EXPECT_EQ(sizeof(int), size_allocated) << "allocate_int(int): pointer does not appear to point to a single dynamically allocated int";
    EXPECT_EQ(42, *p) << "allocate_int(int): dynamically allocated int not properly initialized";

    delete p;

    p = allocate_int(17);
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(17, *p) << "allocate_int(int): dynamically allocated int not properly initialized";

    delete p;

    p = allocate_int(12345);
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(12345, *p) << "allocate_int(int): dynamically allocated int not properly initialized";

    delete p;

    p = allocate_int(-1734);
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(-1734, *p) << "allocate_int(int): dynamically allocated int not properly initialized";

    delete p;
}

TEST(CSCITest, allocate_array) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    int* p = allocate_array(10, 0);
    size_t num_allocated  = _newtracker_count() - before;
    size_t size_allocated = _newtracker_getsize(p);
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(1, num_allocated) << "allocate_array(): nothing appears to have been allocated, or it was already deallocated, or too many items were allocated";
    EXPECT_EQ(sizeof(int) * 10, size_allocated) << "allocate_array(): pointer does not point to a dynamically allocated array of the correct size";
    for (int i = 0; i < 10; i++) EXPECT_EQ(0, p[i]) << "allocate_array(): array value not initialized correctly";

    delete[] p;

    p = allocate_array(17, 42);
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    for (int i = 0; i < 17; i++) EXPECT_EQ(42, p[i]) << "allocate_array(): array value not initialized correctly";
    delete[] p;

}

TEST(CSCITest, allocate_string2) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    string* p = allocate_string('H', 'i', '!');
    size_t num_allocated  = _newtracker_count() - before;
    size_t size_allocated = _newtracker_getsize(p);
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_LT(0, num_allocated) << "allocate_string(): nothing appears to have been allocated, or it has already been deallocated";
    EXPECT_EQ(sizeof(string), size_allocated) << "allocate_string(): pointer appears to point to something other than a single dynamically allocated string object";
    EXPECT_EQ(string("Hi!"), *p) << "allocate_string(): incorrect string value";

    delete p;

    p = allocate_string('a', 'b', 'c');
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(string("abc"), *p) << "allocate_string(): incorrect string value";
    delete p;

    p = allocate_string('f', 'o', 'o');
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(string("foo"), *p) << "allocate_string(): incorrect string value";
    delete p;

    p = allocate_string('x', 'y', 'z');
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    EXPECT_EQ(string("xyz"), *p) << "allocate_string(): incorrect string value";
    delete p;

}

TEST(CSCITest, allocate_2d_array) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    double** pp = allocate_2d_array(10, 20, 30);
    size_t num_allocated  = _newtracker_count() - before;
    size_t size_allocated = _newtracker_getsize(pp);
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    ASSERT_EQ(10 * sizeof(double*), size_allocated) << "allocate_2d_array(): outer array appears to be of wrong size";
    
    ASSERT_EQ(11, num_allocated) << "allocate_2d_array(): total allocated arrays not correct";
    for (int i = 0; i < 10; i++) {
        size_t sz_allocated = _newtracker_getsize(pp[i]);
        ASSERT_EQ(20 * sizeof(double), sz_allocated) << "allocate_2d_array(): inner array appears to be of wrong size";
        for (int j = 0; j < 20; j++) {
            EXPECT_EQ(30, pp[i][j]) << "allocate_2d_array(): inner array value incorrectly initialized";
        }
    }

    for (int i = 0; i < 10; i++) {
        delete[] pp[i];
    }
    delete[] pp;
}

TEST(CSCITest, deallocate_int) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    int *p = new int;
    deallocate_int(p);
    size_t num_allocated  = _newtracker_count() - before;
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(0, num_allocated) << "deallocate_int(): pointer not deallocated";
}

TEST(CSCITest, deallocate_array) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    int *p = new int[100];
    deallocate_array(p);
    size_t num_allocated  = _newtracker_count() - before;
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(0, num_allocated) << "deallocate_array(): pointer not deallocated";
}

TEST(CSCITest, deallocate_2d_array) {
    _newtracker_reset_error();

    int before = _newtracker_count();
    double** pp = new double*[10];
    for (int i = 0; i < 10; i++) {
        pp[i] = new double[4];
    }
    deallocate_2d_array(pp, 10);
    size_t num_allocated  = _newtracker_count() - before;
    
    ASSERT_FALSE(_newtracker_has_error()) << _newtracker_strerror();
    
    ASSERT_EQ(0, num_allocated) << "deallocate_2d_array(): Not all memory was correctly deallocated";
}


