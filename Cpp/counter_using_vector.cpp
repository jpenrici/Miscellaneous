/*
 Contador utilizando Vetor:
     Min = 0, Max = 1
 [1] [2] [3] [4] [...] [n]
  0   0   0   0         0 
  0   0   0   0         1 
  0   0   0   1         0 
  0   0   0   0         1
 ... ... ... ...  ...  ...

 num: quantidade de números no vetor
 min: limite mínimo
 max: limete máximo
 value: valor inicial para todos os números do vetor
*/

#include <iostream>
#include <sstream>
#include <vector>

using std::cout;
using std::string;
using std::vector;
using std::stringstream;

class Counter {
public:
    Counter(int num, int min, int max, int value): min(min), max(max) {
        if (value < min) value = min;
        if (value > max) value = max;
        counter.resize(num, value);
        vSize = counter.size() - 1;
    };
    ~Counter(){};

    void add() { calc( counter, vSize,  1); }
    void sub() { calc( counter, vSize, -1); }
    bool calc(vector<int>& v, int pos, int value);
    string view();

private:
    int min, max, vSize;
    vector<int> counter;
    string int2str (int value);
};

string Counter::int2str (int value)
{
    stringstream strInt;
    strInt << value;
    return strInt.str();
}

bool Counter::calc(vector<int>& v, int pos, int value)
{
    if (value == 0) return false;
    if (pos < 0 && pos > vSize) return false;
    if (v.empty()) return false;

    v[pos] = v[pos] + value;

    if (v[pos] > max) {
        v[pos] = min;
        if (pos > 0) calc(v, pos -1, value);
    } else {
        if (v[pos] < min) {
            v[pos] = max;
            if (pos > 0) calc(v, pos -1, value);
        }
    }
    return true;
}

string Counter::view()
{
    string s = "[ ";
    for (int i = 0; i < vSize; ++i)
        s = s + int2str(counter[i]) + ", ";
    s = s + int2str(counter[vSize]) + " ]";
    return s;
}

int main()
{
    int i;
    Counter a (4, 0, 2, 0);
    cout << a.view() << " *\n";

    for (i = 1; i <= 80; ++i) {
        a.add();
        cout << a.view() << '\n';
    }
    cout << '\n' << a.view() << " *\n";

    for (i = 1; i <= 82; ++i) {
        a.sub();
        cout << a.view() << '\n';
    }
    cout << '\n' << a.view() << " *\n";

    return 0;
}
