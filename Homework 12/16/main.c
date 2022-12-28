#include<stdio.h>

void subprogram(char a[], int b[]);

int main(){
    char a[]="10100111b01100011b110b101011b";
    int b[]={0,0,0,0,0,0,0,0,0,0};
    subprogram(a,b);
    for (int i=0;b[i]!=0;i++){
        printf("%d ",b[i]);
    }
    return 0;
}