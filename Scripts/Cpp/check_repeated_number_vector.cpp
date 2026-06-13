/*
Checar se vetor contém números repetidos e em quantidade par.
Retorna verdadeiro se encontrar o primeiro número repetido em quantidade par.

Exemplo:
{2, 2} true
{2, 3} false
{2, 2, 3} true
{2, 2, 2, 3} false
*/

#include <iostream>
using std::cout;
using std::boolalpha;
using std::domain_error;

#include <vector>
using std::vector;

#include <algorithm>
using std::sort;
using std::copy;

#include <iterator>
using std::ostream_iterator;

// Validar Tipo
template<typename T>
bool validate_type(vector<T> v)
{
    if (typeid(int) == typeid(T)) return true;
    if (typeid(float) == typeid(T)) return true;
    if (typeid(double) == typeid(T)) return true;
    throw domain_error("Type: int, float or double!");
    return false;
}

// Exibir vetor
template<typename T>
void view_vector(vector<T> v)
{
    copy(v.begin(), v.end() - 1, ostream_iterator<T>(std::cout, " "));
    if (!v.empty()) std::cout << v.back() << '\n';
}

// Checar vetor
template<typename T>
bool check_repetition(vector<T> v) {

    // validar tipo
    bool validate = validate_type(v);

    // resposta rápida
    if (v.empty()) return false;
    if (v.size() == 1) return false;
    if (v.size() == 2) {
        if (v[0] == v[1]) return true;
    }

    // resposta lenta
    T last;
    int count(1);

    sort(v.begin(), v.end());
    // view_vector(v);

    while(!v.empty()) {
        last = v.front();
        v.erase(v.begin());
        if (v.empty()) break;
        if (last == v.front()) {
            count++;
            continue;
        }
        if ((count % 2) == 0) break;
        count = 1;
    }

    if ((count % 2) == 0) {
        // std::cout << "first repeated number and even number: " << last << '\n';
        return true;
    }

    return false;
}

template<typename T>
void test(vector<T> v)
{
    cout << boolalpha << check_repetition(v) << '\n';
}

int main()
{
    
    test(vector<int>{});                    // false
    test(vector<int>{1});                   // false
    test(vector<int>{2,1});                 // false
    test(vector<int>{2,1,2});               // true, 2 repetido em número par
    test(vector<int>{2,1,2,3,2});           // false
    test(vector<int>{2,1,2,3,2,1,3});       // true, 1 repetido em número par 
    test(vector<int>{2,1,2,3,2,1,1,3,4});   // true, 3 repetido em número par

    test(vector<float>{2.1,1.1,2.1});       // true, 2.1 repetido em número par 
    test(vector<double>{2.2,1.1,2.3,3.1,2.1,1.2,1.3,3.2,4.0});  // false    

    // test(vector<char>{'?'});             // Não permitido
    // test(vector<string>{"Error"});       // Não permitido

    return 0;
}