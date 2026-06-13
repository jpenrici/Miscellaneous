#include <iostream>
#include <vector>

using namespace std;

string remove_characters(string text, char character)
{
    // delete front character
    while(text.front() == character) {
        text.erase(0, 1);
    }

    // delete back character
    while (text.back() == character) {
        text.erase(text.size() - 1, 1);
    }

    // delete internal duplicates
    string output = "";
    for (int i = 0; i < text.size(); ++i) {
        output += text[i];
        while(text[i] == character) {
            i = i + 1;
            if (text[i] != character) {
                output += text[i];
                break;
            }
        }
    }

    return output;
}

int main(int argc, char const *argv[])
{
    vector<vector<string> > test {
        // {char, text}     
        {"*", "*ABC***A*"},
        {" ", " ABC   A "},
        {"0", "0A0010020"}
    };

    for (auto t : test) {
        cout << "Test {'" << t.front() << "', '" << t.back() << "'} : ";
        cout << remove_characters(t.back(), t.front().front()) << endl;

    }

    return 0;
}