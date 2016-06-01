int* allocate_int();
int* allocate_int(int x);
int* allocate_array(int sz, int val);
string* allocate_string(char a, char b, char c);
double** allocate_2d_array(int m, int n, double val);

void deallocate_int(int* p);
void deallocate_array(int* p);
void deallocate_2d_array(double** pp, int m);
