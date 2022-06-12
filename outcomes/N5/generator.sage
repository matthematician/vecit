class Generator(BaseGenerator):
    def data(self):
        
        x=var("x")
        y=var("y")
        z=var("z")
        
        #choose 3 random points non colinear, A, B, C, then compute vectors AB, AC.
        
        magnorm=0
        A = vector([0,0,0])
        B = vector([0,0,0])
        C = vector([0,0,0])
        AB = B-A
        AC = C-A
        
        while(magnorm==0 or [AB[0],AB[1],AB[2],AC[0],AC[1],AC[2]].count(0)<2 or [AB[0],AB[1],AB[2],AC[0],AC[1],AC[2]].count(0)>3 ):
            A=vector([randint(-8,8), randint(-8,8), randint(-8,8)])
            B=vector([randint(-8,8), randint(-8,8), randint(-8,8)])
            C=vector([randint(-8,8), randint(-8,8), randint(-8,8)])
            AB=B-A
            AC=C-A
            cross=AB.cross_product(AC)
            magnorm=(cross[0]^2+cross[1]^2+cross[2]^2 )^(1/2)
        
        
        
        # Make a plane.
        P1=cross[0]
        P2=cross[1]
        P3=cross[2]
        
        k1 = cross[0]*A[0]+cross[1]*A[1]+cross[2]*A[2]
        
        g1 = gcd(gcd(gcd(cross[0],cross[1]),cross[2]),k1)
        
        plane1= (cross[0]*x+cross[1]*y+cross[2]*z) ==  k1

        plane1s= (cross[0]*x+cross[1]*y+cross[2]*z)/g1 ==  k1/g1
        
        
        #Pick a random point and make another plane
        k2=k1
        while(k2==k1):
            D=vector([randint(-8,8), randint(-8,8), randint(-8,8)])
            k2=cross[0]*D[0]+cross[1]*D[1]+cross[2]*D[2]
            
            g2 = gcd(gcd(gcd(cross[0],cross[1]),cross[2]),k2)

                
            plane2= cross[0]*x+cross[1]*y+cross[2]*z ==  k2
            
            plane2s= (cross[0]*x+cross[1]*y+cross[2]*z)/g2 ==  k2/g2

        

        
        return {
            "A": A,
            "B": B,
            "C": C,
            "AB": AB,
            "AC": AC,
            "cross": cross,
            "plane1": plane1,
            "D": D,
            "plane2": plane2,
            "plane1s": plane1s,
            "plane2s": plane2s
            #"k1": k1,
            
        }

    @provide_data
    def graphics(data):
        return {

        }

