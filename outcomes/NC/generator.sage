class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #Position of weight
        u1=randint(-5,5)
        u2=randint(-5,5)
        u3=randint(-5,5)
        
        #direction on which weights fall
        z1=randint(1,5)
        z2=randint(1,5)
        
        z3v=randint(1,10)
        z3w=randint(1,10)
        
        c1=randint(1,4)
        c2=randint(1,4)
        
        #position of v
        v1=c1*z1+u1
        v2=c1*z2+u2
        v3=z3v+u3
        
        #position of w
        w1=-c2*z1+u1
        w2=-c2*z2+u2
        w3=z3w+u3
        
        
        #coefficient
        a=randint(1,4)
        
        weight = a*c2*z3v + a*c1*z3w
        
        
        
        
        
        return {
            "u1": u1,
            "u2": u2,
            "u3": u3,
            "v1": v1,
            "v2": v2,
            "v3": v3,
            "w1": w1,
            "w2": w2,
            "w3": w3,
            "weight": weight,
            
            "dis11": c1*z1,
            "dis12": c1*z2,
            "dis13": z3v,
            
            "dis21": -c2*z1,
            "dis22": -c2*z2,
            "dis23": z3w,
            
            
            "vec11": c2*c1*a*z1,
            "vec12": c2*c1*a*z2,
            "vec13": c2*a*z3v,
            
            "vec21": -c2*c1*a*z1,
            "vec22": -c2*c1*a*z2,
            "vec23": c1*a*z3w,
            
            
        }

 

