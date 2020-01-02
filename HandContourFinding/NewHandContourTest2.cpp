#include<bits/stdc++.h>
using namespace std ;

char ch[500][500] ;
long directionX[]= {0, -1, -1, -1, 0, 1, 1, 1} ,
                   directionY[]= {-1 , -1 , 0 ,1 , 1 , 1 , 0 , -1} , colorCells[500][500], colorWhiteCells[500][500];
long row , col , flag , X , Y ;
vector< pair<long,long> >ans, V;
queue< pair<long,long> >Q ;

bool cheak(int a , int b)
{
    if(a<0 || a==row || b<0 || b==col) return false ;
    return true ;
}

void saveWhitePixelSequence(long a , long b)
{
    long i , j , k , q , w ;
    V.push_back(pair<long , long>(a,b)) ;
    ch[a][b]=(char)flag++ ;
    if(flag>90) flag=65;
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
                V.push_back(pair<long , long>(q,w)) ;
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
    memset(colorCells , 0 , sizeof colorCells) ;
     memset(colorWhiteCells , 0 , sizeof colorWhiteCells) ;
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

            if(cheak(q,w) && !colorCells[q][w])
            {
                colorCells[q][w]=1 ;
                if(colorWhiteCells[q][w])
                {
                    while(!Q.empty()) Q.pop();
                    break;
                }
                if(ch[q][w] == '1')
                {
                    ans.push_back(pair<long , long>(q,w));
                    colorWhiteCells[q][w]=1;
                }
                Q.push(pair<long , long>(q,w)) ;
            }
        }
    }

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

        X=V[ V.size()-1 ].first , Y=V[ V.size()-1 ].second ;
        while(findWhitePixel(X,Y))
        {
            saveWhitePixelSequence(X,Y) ;
            X=V[ V.size()-1 ].first , Y=V[ V.size()-1 ].second ;
        }

        printf("Ans = \n") ;


        for(i=0 ; i<V.size() ; i++)
            printf("%ld   %ld\n",V[i].first,V[i].second) ;
    }
    return 0 ;
}
