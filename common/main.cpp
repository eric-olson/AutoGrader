#include "gtest/gtest.h"

extern void install_backtrace_handler();

int main(int argc, char *argv[]) {
	// Signal handler setup
	install_backtrace_handler();

	// Googletest boilerplate
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

