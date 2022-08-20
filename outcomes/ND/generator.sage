class Generator(BaseGenerator):
    def data(self):
        
        x=var("x")
        y=var("y")
        z=var("z")
        t=var("t")
        
        #choose 3 random points non colinear, A, B, C, then compute vectors AB, AC.
        
        
        #pick two vectors
        
        U= vector([randint(-5,5), randint(-5,5), randint(-5,5)])
        V= vector([randint(-5,5), randint(-5,5), randint(-5,5)])
        
        dot1 = 0
        normcross1 = 0
        
        while(normcross1==0 or [U[0],U[1],U[2],V[0],V[1],V[2]].count(0)<2 or [U[0],U[1],U[2],V[0],V[1],V[2]].count(0)>3 or dot1==0 ):
            U= vector([randint(-5,5), randint(-5,5), randint(-5,5)])
            V= vector([randint(-5,5), randint(-5,5), randint(-5,5)])
            cross = U.cross_product(V)
            dot1 = U.dot_product(V)
            normcross1=(cross[0]^2+cross[1]^2+cross[2]^2 )^(1/2)
        
        
        #pick a point
        
        P = vector([randint(-3,3), randint(-3,3), randint(-3,3)])
        
        # pick two t values
        
        tu=0
        tv=0
        
        while tu==tv:
            tu=randint(-4,4)
            tv=randint(-4,4)
        
        #LINES
        Lu=vector([U[0]*(t-tu)+P[0], U[1]*(t-tu)+P[1], U[2]*(t-tu)+P[2]])
        Lv=vector([V[0]*(t-tv)+P[0], V[1]*(t-tv)+P[1], V[2]*(t-tv)+P[2]])
        
        #"Find the plane containing Lu and orthagonal to plane"
        
        k0=randint(-20,20)        
        k1 = cross[0]*P[0]+cross[1]*P[1]+cross[2]*P[2]
        
        #Find the intersection of two planes
        
        Q = vector([randint(-3,3), randint(-3,3), randint(-3,3)])
        ku = U[0]*Q[0]+U[1]*P[1]+U[2]*P[2]
        kv = V[0]*Q[0]+V[1]*P[1]+V[2]*P[2]
        
        
        Lcross=vector([cross[0]*t+Q[0], cross[1]*t+Q[0], cross[2]*t+Q[0],])
        
        
        
        

        

        
        return {
            "U":U,
            "V": V,
            "cross": cross,
            "Lu": Lu,
            "Lv": Lv,
            "Lcross": Lcross,
            "P": P,
            "tu": tu,
            "tv": tv,
            "k0": k0,
            "k1": k1,
            "ku": ku,
            "kv": kv,
            "planeU": U[0]*x+U[1]*y+U[2]*z,
            "planeV": V[0]*x+V[1]*y+V[2]*z,
            "planecross": cross[0]*x+cross[1]*y+cross[2]*z,
            #"U0":U[0],
            #"U1":U[1],
            #"U2":U[2],
            #"V0":V[0],
            #"V1":V[1],
            #"V2":V[2],
            #"cross0":cross[0],
            #"cross1":cross[1],
            #"cross2":cross[2],
            
        }

    @provide_data
    def graphics(data):
        return {

        }

