#include <gtest/gtest.h>
#include <cstdlib>

using namespace std;

#include "solution.cpp"

int cheap_hash(int n) {
	double seed = n * 0.6180339894722318;
	return (seed - int(seed)) * 1000000;
}

// "low" tests - for lists handling 4 or fewer elements

TEST(CSCITest, base) {
	list l;
}	

TEST(CSCITest, sizezero) {
	list l;
	ASSERT_EQ(0, l.size()) << ": initialized list not size zero";
}

TEST(CSCITest, addone) {
	list l;
	l.add(17);
	ASSERT_EQ(1, l.size()) << ": list not size one after adding one element";
}

TEST(CSCITest, addfour) {
	list l;
	l.add(17);
	l.add(32);
	l.add(103934);
	l.add(0);
	ASSERT_EQ(4, l.size()) << ": list not size 4 after adding 4 elements";
}

TEST(CSCITest, getone) {
	list l;
	l.add(109570);
	ASSERT_EQ(109570, l.get(0)) << ": list contents incorrect after adding 1 element";
}

TEST(CSCITest, getfour) {
	list l;
	l.add(17);
	l.add(32);
	l.add(103934);
	l.add(101);
	ASSERT_EQ(4, l.size()) << ": list size incorrect after adding 4 elements";
	ASSERT_EQ(17, l.get(0)) << ": list contents incorrect after adding 4 elements";
	ASSERT_EQ(32, l.get(1)) << ": list contents incorrect after adding 4 elements";
	ASSERT_EQ(103934, l.get(2)) << ": list contents incorrect after adding 4 elements";
	ASSERT_EQ(101, l.get(3)) << ": list contents incorrect after adding 4 elements";
}

TEST(CSCITest, insertfront) {
	list l;
	l.add(17);
	l.add(23);
	l.insert(42,0);
	ASSERT_EQ(3, l.size()) << ": list size incorrect after inserting at front";
	ASSERT_EQ(42, l.get(0)) << ": list contents incorrect after inserting at front";
	ASSERT_EQ(17, l.get(1)) << ": list contents incorrect after inserting at front";
	ASSERT_EQ(23, l.get(2)) << ": list contents incorrect after inserting at front";
}

TEST(CSCITest, insertrear) {
	list l;
	l.add(17);
	l.insert(42,1);
	ASSERT_EQ(2, l.size()) << ": list size incorrect after inserting at rear";
	ASSERT_EQ(17, l.get(0)) << ": list contents incorrect after inserting at rear";
	ASSERT_EQ(42, l.get(1)) << ": list contents incorrect after inserting at rear";
}

TEST(CSCITest, insertmiddle) {
	list l;
	l.add(17);
	l.add(300);
	l.insert(42,1);
	l.insert(711,1);
	ASSERT_EQ(4, l.size()) << ": list size incorrect after inserting in middle";
	ASSERT_EQ(17, l.get(0)) << ": list contents incorrect after inserting in middle";
	ASSERT_EQ(711, l.get(1)) << ": list contents incorrect after inserting in middle";
	ASSERT_EQ(42, l.get(2)) << ": list contents incorrect after inserting in middle";
	ASSERT_EQ(300, l.get(3)) << ": list contents incorrect after inserting in middle";
}

TEST(CSCITest, erasefront) {
	list l;
	l.add(17);
	l.add(42);
	l.erase(0);
	ASSERT_EQ(1, l.size()) << ": list size incorrect after erasing from front";
	ASSERT_EQ(42, l.get(0)) << ": list contents incorrect after erasing from front";
}

TEST(CSCITest, eraserear) {
	list l;
	l.add(17);
	l.add(42);
	l.erase(1);
	ASSERT_EQ(1, l.size()) << ": list size incorrect after erasing from rear";
	ASSERT_EQ(17, l.get(0)) << ": list contents incorrect after erasing from rear";
}

TEST(CSCITest, erasemiddle) {
	list l;
	l.add(17);
	l.add(42);
	l.add(300);
	l.erase(1);
	ASSERT_EQ(2, l.size()) << ": list size incorrect after erasing from middle";
	ASSERT_EQ(17, l.get(0)) << ": list contents incorrect after erasing from middle";
	ASSERT_EQ(300, l.get(1)) << ": list contents incorrect after erasing from middle";
}

TEST(CSCITest, mixedops) {
	list l;
	l.add(17);
	l.add(42);
	l.add(300);
	l.erase(1);
	l.insert(4, 1);
	l.erase(0);
	l.insert(99, 1);
	ASSERT_EQ(3, l.size()) << ": list size incorrect after mixed operations";
	ASSERT_EQ(4, l.get(0)) << ": list contents incorrect after mixed operations";
	ASSERT_EQ(99, l.get(1)) << ": list contents incorrect after mixed operations";
	ASSERT_EQ(300, l.get(2)) << ": list contents incorrect after mixed operations";
}

// "medium" tests - with dynamic resizing, but no copy constructor
// or assignment operator
TEST(CSCITest, addmany) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.add(cheap_hash(i));
	}
}

TEST(CSCITest, getmany) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.add(cheap_hash(i));
	}
	ASSERT_EQ(50000, l.size()) << ": list size incorrect after adding many elements";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l.get(i)) << ": list contents incorrect after adding many elements";
	}
}

TEST(CSCITest, insertmany) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.insert(cheap_hash(i), i);
	}
	ASSERT_EQ(50000, l.size()) << ": list size incorrect after inserting many elements";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l.get(i)) << ": list contents incorrect after inserting many elements";
	}
}

TEST(CSCITest, mixedmany) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.add(i);
	}
	
	// erase 10 from the middle
	for (int i = 0; i < 10; i++) {
		l.erase(40000);
	}

	// insert 5 into middle elsewhere
	for (int i = 0; i < 5; i++) {
		l.insert(i, 30000);
	}

	ASSERT_EQ(49995, l.size()) << ": list size incorrect after many mixed operations";
	for (int i = 0; i < 30000; i++) {
		ASSERT_EQ(i, l.get(i)) << ": list contents incorrect after many mixed operations";
	}
	for (int i = 30000; i < 30005; i++) {
		ASSERT_EQ(30004 - i, l.get(i)) << ": list contents incorrect after many mixed operations";
	}
	for (int i = 30005; i < 40005; i++) {
		ASSERT_EQ(i-5, l.get(i)) << ": list contents incorrect after many mixed operations";
	}
	for (int i = 40005; i < 49995; i++) {
		ASSERT_EQ(i+5, l.get(i)) << ": list contents incorrect after many mixed operations";
	}
}

// "high" tests - tests for working copy constructor & assignment operator

TEST(CSCITest, copylarge) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.add(cheap_hash(i));
	}

	list l2(l);
	ASSERT_EQ(50000, l2.size()) << ": copy of list does not match original";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l2.get(i)) << ": copy of list does not match original";
	}

	// modify list 1, see that list 2 is unaffected
	for (int i = 0; i < 10; i++) {
		l.add(i);
	}
	ASSERT_EQ(50000, l2.size()) << ": copy of list resized after adding to original";

	for (int i = 0; i < 1000; i++) {
		l.erase(l.size()-1);
	}
	ASSERT_EQ(50000, l2.size()) << ": copy of list resized after modifying original";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l2.get(i)) << ": copy of list modified after modifying original";
	}

	// modify list 2, see that list 1 is unaffected
	for (int i = 0; i < 2000; i++) {
		l2.erase(l2.size()-1);
	}
	ASSERT_EQ(49010, l.size()) << ": original list resized after erasing in copy";
	for (int i = 0; i < 49010; i++) {
		ASSERT_EQ(cheap_hash(i), l.get(i)) << ": original list modified after modifying copy";
	}
}

TEST(CSCITest, assignlarge) {
	list l;
	for (int i = 0; i < 50000; i++) {
		l.add(cheap_hash(i));
	}

	list l2;
	for (int i = 0; i < 1000; i++) {
		l2.add(i);
	}
	l2 = l;

	ASSERT_EQ(50000, l2.size()) << ": assigned list does not match original";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l2.get(i)) << ": assigned list does not match original";
	}

	// modify list 1, see that list 2 is unaffected
	for (int i = 0; i < 10; i++) {
		l.add(i);
	}
	ASSERT_EQ(50000, l2.size()) << ": assigned list resized after modifying original";

	for (int i = 0; i < 1000; i++) {
		l.erase(l.size()-1);
	}
	ASSERT_EQ(50000, l2.size()) << ": assigned list resized after modifying original";
	for (int i = 0; i < 50000; i++) {
		ASSERT_EQ(cheap_hash(i), l2.get(i)) << ": assigned list modified after modifying original";
	}

	// modify list 2, see that list 1 is unaffected
	for (int i = 0; i < 2000; i++) {
		l2.erase(l2.size()-1);
	}
	ASSERT_EQ(49010, l.size()) << ": original list resized after modifying assigned list";
	for (int i = 0; i < 49010; i++) {
		ASSERT_EQ(cheap_hash(i), l.get(i)) << ": original list modified after modifying assigned list";
	}
}


