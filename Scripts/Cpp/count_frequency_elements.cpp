#include<vector>
#include<iostream>
#include<iterator>
#include<algorithm>

using namespace std;

template<typename T>
void view_vector(vector<T> v)
{
	switch (v.size())
	{
		case 0:
			break;
		case 1:
			cout << v[0] << '\n';
			break;
		default:
			for(int i = 0; i < v.size() - 1; ++i)
				cout << v[i] << char(32);
			cout << v[v.size() - 1] << '\n';	
	}
}

template<typename T>
void view_frequency(vector<T> v)
{
	switch (v.size())
	{
		case 0:
			cout << "vector empty\n";
			break;
		case 1:
			cout << v[0] << " : 1\n";
			break;
		default:
			vector<T> u;
			u.resize(v.size());
			copy(v.begin(), v.end(), u.begin());
			sort(u.begin(), u.end());
			u.erase(unique(u.begin(), u.end()), u.end());
			for(auto n: u) {
				cout << n << ":" << count(v.begin(), v.end(), n) << '\n';
			}		
	}
}

template<typename T>
void test(vector<T> v)
{
	view_vector(v);
	view_frequency(v);
	cout << '\n';
}

int main()
{
	test(vector<int>{});
	test(vector<int>{1});
	test(vector<int>{1, 2, 4, 5, 1, 4, 5, 10, 0, 0, 2, 3});
	test(vector<float>{1.15, 2.28, 1.13, 1.13, 3.35});
	test(vector<char>{'@','%','@','#','*','+','@','!','!','!'});
	test(vector<string>{"Car", "Dog", "Cat", "Cat", "Dog"});

	return 0;
}