class Generator(BaseGenerator):
    def data(self):
        # Randomly choose two points P, Q in space, the displacement vectors between which have exactly one coordinate equal to zero and the other two coordinates have a nontrivial common factor. Also don't want both points in the same coordinate plane.
        P = vector([1,1,1])
        Q = vector([1,1,1])
        while(True):
            P = vector([randrange(-8,8),randrange(-8,8),randrange(-8,8)])
            Q = vector([randrange(-8,8),randrange(-8,8),randrange(-8,8)])
            V = [Q[0]-P[0],Q[1]-P[1],Q[2]-P[2]]
            if( V.count(0) == 1 and P[0]^2+Q[0]^2 > 0 and P[1]^2+Q[1]^2 > 0 and P[2]^2+Q[2]^2 > 0):
                W = [V[0],V[1],V[2]]
                W.remove(0)
                a = gcd(W[0],W[1])
                if( a > 1 ):
                    break
        tt = a*choice([-1,1])        
        k = choice([1,2,3])
        V = vector(V)
        
        var('t')
        r = P+t*V
        rr = P + (t+a)*V/a
        
        # Option 1: Give point and give parametric equations of a parallel line
        if( k == 1 ):
            L = P + choice([-1,1])*choice([2,3,4])*V + t*V
            first_condition = "contains the point P("+str(P[0])+","+str(P[1])+","+str(P[2])+")"
            second_condition = "is parallel to the line with parametric vector equation r(t)=("+str(L[0]).replace('*','')+" , "+str(L[1]).replace('*','')+" , "+str(L[2]).replace('*','')+")"
            
        # Option 2: Give two intersecting planes
        if( k == 2 ):
            # Pick two vectors perpendicular to V
            n1 = V.cross_product(vector([1,0,1]))
            if( V.inner_product(vector([0,1,-2])) != 0 ):
                n2 = V.cross_product(vector([0,1,-2]))
            else:
                n2 = V.cross_product(vector([1,-2,0]))
            [b1,b2] = [n1.inner_product(P),n2.inner_product(P)]
            p1 = product([n for n in [n1[0],n1[1],n1[2],b1] if n != 0])
            nn1 = [p1 if n == 0 else n for n in [n1[0],n1[1],n1[2],b1]]
            g1 = gcd(gcd(gcd(nn1[0],nn1[1]),nn1[2]),nn1[3])
            n1 /= g1
            b1 /= g1
            p2 = product([n for n in [n2[0],n2[1],n2[2],b2] if n != 0])
            nn2 = [p2 if n == 0 else n for n in [n2[0],n2[1],n2[2],b2]]
            g2 = gcd(gcd(gcd(nn2[0],nn2[1]),nn2[2]),nn2[3])
            n2 /= g2
            b2 /= g2
            
            var('x','y','z')
            plane1 = n1[0]*x + n1[1]*y + n1[2]*z
            plane2 = n2[0]*x + n2[1]*y + n2[2]*z

            first_condition = "is the intersection of the plane "+str(plane1).replace('*','')+" = "+str(b1)
            second_condition = "the plane "+str(plane2).replace('*','')+" = "+str(b2)
            
            
        # Option 3: Give two points
        if( k == 3 ):
            first_condition = "passes through the point P("+str(Q[0])+","+str(Q[1])+","+str(Q[2])+")"
            second_condition = "the point Q("+str(P[0])+","+str(P[1])+","+str(P[2])+")"
        
        #surface = x^2+y^2
        return {
            "p": P,
            "q": Q,
            "v": V,
            "t": tt,
            "first_condition": first_condition,
            "second_condition": second_condition,
            "r1": r,
            "r2": rr
        }

    @provide_data
    def graphics(data):
        return {

        }

