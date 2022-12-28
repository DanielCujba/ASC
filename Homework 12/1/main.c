#include<stdio.h>
void subprogram(int* p,int a);
int main(){
    int a=0x12345678;
    int p[8];
    subprogram(p,a);
    for (int i=7;i>=0;i--){
        printf("%x ",p[i]);
    }
    return 0;
}