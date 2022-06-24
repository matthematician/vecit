class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y z r theta phi rho dummy')
        
        
        V=[x,y,z]
        shuffle(V)
        w1=V[0]
        w2=V[1]
        w3=V[2]
        
        pythagc=w1^2+w2^2
        pythags=w1^2+w2^2+w3^2
        
        
        #pick a problem type
        scenario=choice(['cylindrical', 'spherical'])
        
        
        if scenario=='cylindrical':
            #find bounds
            c=randint(1,4)
            k=randint(1,4)
            r2=randint(2,5)
            parabaloid=c*w1^2+c*w2^2-k
            plane=(r2)^2*c-k
            
            h1=c*(r)^2-k
            h2=plane
            r1=0
            r2=r2
            theta1=0
            theta2=2*pi
            
            #pick functions
            
            f(w1,w2,w3, dummy)=choice([
                    randint(1,5)*w3/(dummy)^(1/2),
                    randint(1,5)*w3*dummy,
                    randint(1,3)*dummy-randint(1,3)*w3,
                ])
            
            g(r, theta, w3)=f(r*cos(theta), r*sin(theta), w3, r^2)*r
            
            integ = definite_integral(definite_integral( definite_integral( g(r, theta, w3), w3, h1, h2 ), r, r1, r2 ), theta, theta1, theta2)
            
            return {
                scenario: True,
                "f": f(w1,w2,w3,pythagc),
                "g": g(r, theta, w3),
                "h1": h1,
                "h2": h2,
                "r1": r1,
                "r2": r2,
                "w1": w1,
                "w2": w2,
                "w3": w3,
                "theta1": theta1,
                "theta2": theta2,
                "integ": integ,
                "plane": plane,
                "parabaloid": parabaloid,
            }
            
        if scenario=='spherical':
            #find bounds
            rho1=randint(1,4)
            rho2=randint(1,4)+rho1
           
            theta1=0
            theta2=2*pi
            phi1=0
            phi2=pi
            
            #pick functions
            
            f(w1,w2,w3, dummy)=choice([
                    randint(1,5)/(dummy)^(1/2),
                ])
            
            g(rho, theta, phi)=f(rho*sin(phi)*cos(theta), rho*cos(phi)*sin(theta), rho*cos(phi), rho^2)*rho^2*sin(phi)
            
            integ = definite_integral(definite_integral( definite_integral( g(rho, theta, phi), rho, rho1, rho2 ), phi, phi1, phi2 ), theta, theta1, theta2)
            
            return {
                scenario: True,
                "f": f(w1,w2,w3,pythags),
                "g": g(rho, theta, phi),
                "rho1": rho1,
                "rho2": rho2,
                "phi1": phi1,
                "phi2": phi2,
                "w1": w1,
                "w2": w2,
                "w3": w3,
                "theta1": theta1,
                "theta2": theta2,
                "integ": integ,
            }
        
        