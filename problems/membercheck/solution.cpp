#include <set>

vector<string> whos_dishonest(vector<string> club1,
                              vector<string> club2,
                              vector<string> club3) {
	set<string> cheaters;
	set<string> c2(club2.begin(), club2.end());
	set<string> c3(club3.begin(), club3.end());

	// check club 1 attendees against other 2
	for (vector<string>::iterator it = club1.begin(); it != club1.end(); it++) {
		if (c2.find(*it) != c2.end() || c3.find(*it) != c3.end()) {
			cheaters.insert(*it);
		}
	}

	// now check club 2 against club 3
	for (vector<string>::iterator it = club2.begin(); it != club2.end(); it++) {
		if (c3.find(*it) != c3.end()) {
			cheaters.insert(*it);
		}
	}

	vector<string> ans(cheaters.begin(), cheaters.end());
	return ans;
}
