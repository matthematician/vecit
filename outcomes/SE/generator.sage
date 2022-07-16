class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y z r theta phi rho dummy')
        
        
        V=[x,y,z]
        shuffle(V)
        w1=V[0]
        w2=V[1]
        w3=V[2]
        
        
        delt(x,y,z)=randint(1,5)*x+randint(1,5)*y+randint(1,5)*z
        
        #pick a problem type
        scenario=choice(['inertia', 'center'])
        
        
        if scenario=='inertia':
            #find bounds
            
            x1=0
            x2=randint(1,5)
            y1=0
            y2=randint(1,5)
            z1=0
            z2=randint(1,5)
            
            mass= definite_integral( definite_integral( definite_integral(delt(x,y,z), x, x1, x2 ) ,y, y1, y2), z, z1, z2)
            
            Iw3=definite_integral( definite_integral( definite_integral((w1^2+w2^2)*delt(x,y,z), x, x1, x2 ) ,y, y1, y2), z, z1, z2)
            
            rgw3=(Iw3/mass)^(1/2)
            
            
            
            return {
                scenario: True,
                "delt": delt(x,y,z),
                "x1": x1,
                "x2": x2,
                "y1": y1,
                "y2": y2,
                "w1": w1,
                "w2": w2,
                "w3": w3,
                "z1": z1,
                "z2": z2,
                "mass": mass,
                "I": Iw3,
                "r": rgw3,
            }
            
        if scenario=='center':
            #find bounds
            
            x1=0
            x2=randint(1,5)
            y1=0
            y2=randint(1,5)
            z1=0
            z2=randint(1,5)
            
            mass= definite_integral( definite_integral( definite_integral(delt(x,y,z), x, x1, x2 ) ,y, y1, y2), z, z1, z2)
            
            Tw3=definite_integral( definite_integral( definite_integral((w3)*delt(x,y,z), x, x1, x2 ) ,y, y1, y2), z, z1, z2)
            
            Cw3=Tw3/mass
            
            
            
            return {
                scenario: True,
                "delt": delt(x,y,z),
                "x1": x1,
                "x2": x2,
                "y1": y1,
                "y2": y2,
                "w1": w1,
                "w2": w2,
                "w3": w3,
                "z1": z1,
                "z2": z2,
                "mass": mass,
                "T": Tw3,
                "C": Cw3,
            }
        
        