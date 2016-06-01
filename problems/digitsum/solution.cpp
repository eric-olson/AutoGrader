int digit_sum(int x) {
  int ans = 0;
  while (x > 0) {
    ans += x % 10;
    x = x / 10;
  }
  return ans;
}
