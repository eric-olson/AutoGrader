#ifndef ASSOC_H
#define ASSOC_H

#include <iostream>
#include "gtest/gtest.h"

// class association is a quick & dirty replacement for pair which can
// be initialized the same way, but which prints out as key:value
// instead of 
template <class K, class V>
class association {
public:
	K key;
	V value;

	association(const association& a) = default;
	association(const K& k, const V& v) {
		key = k;
		value = v;
	}
};

template <class K, class V>
void PrintTo(const association<K,V>& a, ::std::ostream* os) {
	*os << ::testing::PrintToString(a.key);
	*os << ":";
	*os << ::testing::PrintToString(a.value);
}

#endif

