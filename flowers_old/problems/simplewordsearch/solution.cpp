#include <set>

int points(vector<string> player, vector<string> dictionary) {
	set<string> player_set(player.begin(), player.end());

	int ans = 0;

	for (vector<string>::iterator it = dictionary.begin(); it != dictionary.end(); it++) {
		if (player_set.find(*it) != player_set.end())
			ans += (it->length())*(it->length());
	}

	return ans;
}
