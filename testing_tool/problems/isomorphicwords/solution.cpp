#include <map>
#include <set>

bool is_isomorphic(string a, string b) {
	map<char,char> m;
	set<char> mapped;

	for (int i = 0; i < a.length(); i++) {
		char ca = a[i];
		char cb = b[i];
	
		if (m.find(ca) != m.end()) {
			if (m[ca] != cb) return false;
		} else if (mapped.find(cb) != mapped.end()) {
			return false;
		} else {
			m[ca] = cb;
			mapped.insert(cb);
		}
	}
	return true;
}

int count_pairs(vector<string> words) {
	int answer = 0;

	for (int i = 0; i < words.size(); i++) {
		for (int j = i + 1; j < words.size(); j++) {
			if (is_isomorphic(words[i], words[j])) answer++;
		}
	}

	return answer;
}

