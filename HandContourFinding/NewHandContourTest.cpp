// color array to find disjoint white pixels
// flag implemented ch array is to find white pixel sequence

#include<bits/stdc++.h>
using namespace std ;

char ch[100][100] ;
long directionX[]= {0, -1, -1, -1, 0, 1, 1, 1} ,
                   directionY[]= {-1 , -1 , 0 ,1 , 1 , 1 , 0 , -1} , color[500][500] ;
long row , col , flag , X , Y ;
struct data
{
    char c ;
    long a , b ;
    data(char cc , long aa , long bb)
    {
        c=cc, a=aa , b=bb ;
    }
} ;
vector< pair<long,long> >ans;
vector<struct data>V ;
queue< pair<long,long> >Q ;
map<pair<long , long>,long>mp ;
bool cheak(int a , int b)
{
    if(a<0 || a==row || b<0 || b==col) return false ;
    return true ;
}

void saveWhitePixelSequence(long a , long b)
{
    long i , j , k , q , w ;
    V.push_back(data(flag,a,b)) ;
    ch[a][b]=(char)flag++ ;
    if(flag>90) flag=65;
    color[a][b]=1;
    Q.push(pair<long , long>(a,b)) ;
    while(!Q.empty())
    {
        i=Q.front().first ;
        j=Q.front().second ;
        Q.pop() ;

        for(k=0 ; k<8 ; k++)
        {
            q=i+directionX[k] ;
            w=j+directionY[k] ;
            if(cheak(q,w) && ch[q][w] == '1')
            {
                V.push_back(data(flag,q,w)) ;
                ch[q][w]=(char)flag++ ;
                if(flag>90) flag=65;
                Q.push(pair<long , long>(q,w)) ;
            }
        }
    }
}

bool findWhitePixel(int a, int b)
{
    long i , j , k , q , w ;
    memset(color , 0 , sizeof color) ;
    Q.push(pair<long , long>(a,b)) ;
    while(!Q.empty())
    {
        i=Q.front().first ;
        j=Q.front().second ;
        Q.pop() ;

        for(k=0 ; k<8 ; k++)
        {
            q=i+directionX[k] ;
            w=j+directionY[k] ;

            if(cheak(q,w) && !color[q][w])
            {
                color[q][w]=1 ;
                if(ch[q][w] == '1')
                {
                    ans.push_back(pair<long , long>(q,w));
                    ch[q][w]='2';
                }
                if(ch[q][w] == '2')
                {
                    while(!Q.empty()) Q.pop();
                    break;
                }
                /*{
                    while(!Q.empty()) Q.pop();
                    X=q;
                    Y=w;
                    return true;
                }*/
                Q.push(pair<long , long>(q,w)) ;
            }
        }
    }
    //printf("H\n");
    if(ans.size())
    {
        long Min=(a-ans[0].first)*(a-ans[0].first)+(b-ans[0].second)*(b-ans[0].second),
             minX=ans[0].first,
             minY=ans[0].second;
        for(int i=0 ; i<ans.size() ; i++)
            if((a-ans[i].first)*(a-ans[i].first)+(b-ans[i].second)*(b-ans[i].second) < Min)
            {
                Min = (a-ans[i].first)*(a-ans[i].first)+(b-ans[i].second)*(b-ans[i].second);
                minX=ans[i].first;
                minY=ans[i].second;
            }
        while(!Q.empty())
            Q.pop() ;
        X=minX;
        Y=minY;
        //     printf("%ld    %ld\n",X,Y);
        ans.clear();
        return true;
    }

    return false ;
}

int main()
{
    long i , j , a , b ;
    bool CuttPoint;
    while(scanf("%ld",&row)!=EOF)
    {
        V.clear() ;
        // memset(color , 0 , sizeof color) ;
        CuttPoint=true;
        char cc=getchar() ;
        flag=65 ;
        for(i=0 ; i<row ; i++)
            gets(ch[i]) ;
        col=strlen(ch[0]) ;
        for(j=row-1 ; j>=0 && CuttPoint ; j--)
            for(i=0 ; i<col ; i++)
                if(ch[j][i] == '1')
                {
                    b=i ;
                    a=j ;
                    CuttPoint=false ;
                    break ;
                }

        saveWhitePixelSequence(a , b) ;

        X=V[ V.size()-1 ].a , Y=V[ V.size()-1 ].b ;
        while(findWhitePixel(X,Y))
        {
            saveWhitePixelSequence(X,Y) ;
            X=V[ V.size()-1 ].a , Y=V[ V.size()-1 ].b ;
        }

        printf("\n") ;

        for(i=0 ; i<row ; i++)
            printf("%ld  %s\n",i,ch[i]);


        for(i=0 ; i<V.size() ; i++)
            printf("%c  %ld   %ld\n",V[i].c,V[i].a,V[i].b) ;
    }
    return 0 ;
}

