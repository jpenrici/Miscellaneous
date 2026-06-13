/*
 * Test : create_snippets_cpp_header.py
 *
 */
#ifndef __Test_H__
#define __Test_H__

#include <iostream>
#include <vector>

using namespace std;

#define TEST 100

 class Test
 {
 public:
    Test() { /* block */ }
    Test(string name) : name(name) {}
    ~Test() { std::cout << "goodbye ..." << std::endl;}
    
    string getName() { return name; }
    string get() { return "Name:" + getName(); }

    string get(
        int num1,
        float num2,
        double num3,
        bool isOk, 
        vector<string> strVector,
        vector<vector< double> > matrix
    );
    
    void setName(string name); // comments
    void clear();   /* comments */

private:
    string name;
};

#endif // __Test_H__
