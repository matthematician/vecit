class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y z')
        
        #pick shape
        
        V=[x, y, z]
        shuffle(V)
        
        v0=V[0]
        v1=V[1]
        v2=V[2]
        
        #find upperbound for V[0]
        c=randint(1,3)
        
        #pick a function
        f(v0)=choice([
                randint(1,3)*v0+randint(0,2),
                v0^2/c,
                (c*v0)^1/2,
                e^(v0)
            ])
        
        #find max value of funtion
        max1=ceil(f(c))
        
        fexp=f(v0)
        
        #find plane
        a=randint(1,3)
        b=randint(1,3)
        m1=max(a,b)
        m2=max1+c
        k=randint(m1*m2+1, m1*m2+5)
        
        plane=a*v0+b*v1+v2
        
        
        upperV2=k-a*v0-b*v1
        
        #pick an Integrand
        
        F(x,y,z)=choice([
                randint(1,5)*x*y*z,
                randint(1,3)*x+randint(1,3)*y+randint(1,3)*z,
                e^v0*randint(1,3)*v1+randint(1,3)*v2
            ])
            
            
        
        integ = definite_integral( definite_integral( definite_integral( F(x,y,z), v2, 0, upperV2 ), v1, 0, f(v0) ), v0, 0, c)

        return {
            "v0": v0,
            "v1": v1,
            "v2": v2,
            "c": c,
            "f": f(v0),
            "F": F(x,y,z),
            "plane": plane,
            "k": k,
            "integ": integ,
            "upperV2": upperV2,
            "max1": max1,
            
        }
    
    @provide_data
    def graphics(data):
        # updated by clontz
        return {"region": implicit_plot3d(data['f']==data['v1'], (data['v0'],0,data['c']), (data['v1'],0,data['max1']), (data['v2'],0,data['k']), opacity=0.5)+implicit_plot3d(data['plane']==data['k'], (data['v0'],0,data['c']), (data['v1'],0,data['max1']), (data['v2'],0,data['k']), opacity=0.5, color='red'), 
                
               }
