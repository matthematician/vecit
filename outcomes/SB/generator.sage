class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('s t')
        
        
        #pick a function
        
        r=randint(1,5)
        
        t1=0
        t2=2*pi
        
        shape= choice(['cylinder', 'torus', 'cone', 'hemisphere'])
        
        
        if shape=='cylinder':
        
            X(s,t)=vector([r*cos(t), r*sin(t), s])
            
            
            s1=randint(-3,3)
            s2=s1+randint(5,10)
        
            
        
        if shape=='torus':
            R=randint(10,20)
            
            X(s,t)=vector([(R+r*cos(s))*cos(t), (R+r*cos(s))*sin(t), r*sin(s)])
            
            
            s1=0
            s2=2*pi
            
        if shape=='cone':
            H=randint(4,10)
            
            X(s,t)=vector([r*(1-s)*cos(t), r*(1-s)*sin(t), H*s])
            
            s1=0
            s2=1
            
            
        if shape=='hemisphere':
            H=randint(4,10)
            
            X(s,t)=vector([r*(cos(s))*cos(t), r*(cos(s))*sin(t), r*sin(s)])
            
            s1=0
            s2=pi/2
             
            
            
        Xs=derivative(X(s,t), s)
        Xt=derivative(X(s,t), t) 
        Cross=Xs.cross_product(Xt)
        Integrand=(Cross[0]^2+Cross[1]^2+Cross[2]^2)^(1/2)
        integ = definite_integral( definite_integral( Integrand, t, t1, t2 ), s, s1, s2 )

        return {
            "X": X(s,t),
            "s1": s1,
            "s2": s2,
            "t1": t1,
            "t2": t2,
            "Xs": Xs,
            "Xt": Xt,
            "Integrand": Integrand,
            "integ": integ,
            "shape": shape,
            
        }
