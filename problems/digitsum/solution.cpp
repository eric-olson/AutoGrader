int sum_digits(int x) {
	return x;
//	int* foo;
//	for (int i = 0; i < 1000000; i++) foo[i] = 10;
	int ans = 0;
	while (x > 0) {
		ans += x % 10;
		x = x / 10;
	}
//	while (true) { ans++; }
//	bleah arg
//	return ans / x;
	return ans;
}
