/*
 * Multiplicação de Matrizes Bidimensionais
 *  
 * Matriz 1 x Matriz 2 = Matriz Resultado
 * <int> x <double/float> = <double>
 * <double/float> x <int> = <double>
 * <double/float> x <double/float> = <double>
 * <int> x <int> = <int>
 *
 */ 

#include <iostream>
using std::cout;
using std::string;

#include <vector>
using std::vector;

#include <type_traits>
using std::is_arithmetic;

#include <stdexcept>

template<typename T>
struct Matrix
{
    int rows, columns;
    vector<vector<T> > value;

    Matrix(){};
    Matrix(int r, int c): rows(r), columns(c) {
     value.resize(rows, vector<T>(columns));
    }
};

// Validar Tipo na Matriz
template<typename T>
bool type_valid(const Matrix<T> m)
{
    if (typeid(int) == typeid(T)) return true;
    if (typeid(double) == typeid(T)) return true;
    if (typeid(float) == typeid(T)) return true;
    throw std::domain_error("Type: int, float or double!");
    return false;
}

// Visualizar matriz
template<typename T>
void print_matrix(const Matrix<T> m, string tag)
{
    cout << tag << "\n";
    for (int r = 0; r < m.rows; ++r)
    {
        for (int c = 0; c <  m.columns; ++c)
        {
            cout << m.value[r][c] << '\t';
        }
        cout << '\n';
    }
}

// Multiplicação de Matrizes
template<typename T1, typename T2, typename Tr>
void multiply(const Matrix<T1> m1, const Matrix<T2> m2, Matrix<Tr>& result)
{
    if (!type_valid(m1)) return;
    if (!type_valid(m2)) return;
    if (!type_valid(result)) return;

    if (m1.columns != m2.rows)
        throw std::domain_error("Could not multiply!");

    result.rows = m2.rows;
    result.columns = m1.columns;
    result.value.clear();
    result.value.resize(result.rows, vector<Tr>(result.columns));

    for (int r = 0; r < m2.rows; ++r)
    {
        for (int c = 0; c < m1.columns; ++c)
        {
            result.value[r][c] = 0;
            for (int i = 0; i < m1.columns; ++i)
            {
                result.value[i][c] += m1.value[i][c] * m2.value[r][i];
            }
        }
    }
}

// Multiplicação: int x int = int
Matrix<int> multiply(const Matrix<int> m1, const Matrix<int> m2)
{
    Matrix<int> result;
    multiply(m1, m2, result);
    return result;
}

// Multiplicação: int/double/float x int/double/float = double
template<typename T1, typename T2>
Matrix<double> multiply(const Matrix<T1> m1, const Matrix<T2> m2)
{
    Matrix<double> result;
    multiply(m1, m2, result);
    return result;
}

// Teste
int main()
{
    vector<vector<int> > vInt = {
        {1, 1, 1},
        {1, 0, 1},
        {1, 1, 1}
    };

    vector<vector<int> > vInt1 = {
        {0, 1},
        {1, 0},
        {0, 1}
    };

    vector<vector<double> > vDouble = {
        {1.1, 1.1, 1.1},
        {1.1, 0.0, 1.1},
        {1.1, 1.1, 1.1}
    };

    vector<vector<float> > vFloat = {
        {1.1, 1.1, 1.1},
        {1.1, 0.0, 1.1},
        {1.1, 1.1, 1.1}
    };  

    Matrix<int> M1(3, 3);
    M1.value = vInt;

    Matrix<int> M1a(3, 2);
    M1a.value = vInt1;

    Matrix<double> M2(3, 3);
    M2.value = vDouble;

    Matrix<float> M3(3,3);
    M3.value = vFloat;
    
    print_matrix(multiply(M1, M1), "M1<int> x M1<int> = Result<int> :");
    print_matrix(multiply(M1, M1a), "M1<int> x M1a<int> = Result<int> :");
    print_matrix(multiply(M1, M2), "M1<int> x M2<double> = Result<double> :");
    print_matrix(multiply(M2, M2), "M2<double> x M2<double> = Result<double> :");
    print_matrix(multiply(M3, M1), "M3<float> x M1<int> = Result<double> :");
    print_matrix(multiply(M3, M3), "M3<float> x M3<float> = Result<double> :");

    return 0;
}