class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y r theta z')
        
        
        #pick region
        
        radius=randint(2,5)
        angles=[0,  pi/2, pi]
        
        hemisphere=choice([-1, 1])
        
        shuffle(angles)
        
        anglebounds=[angles[0], angles[1]]
        
        anglebounds.sort()
        
        theta1=anglebounds[0]
        theta2=anglebounds[1]
        
        if hemisphere==-1:
            theta1=theta1+pi
            theta2=theta2+pi
        
        x1=min(radius*cos(theta1), radius*cos(theta2))
        x2=max(radius*cos(theta1), radius*cos(theta2))
        
        y1=0
        y2=(radius^2-x^2)^(1/2)
        if hemisphere==-1:
            y2=0
            y1=-1*(radius^2-x^2)^(1/2)
            
        
        pythag=x^2+y^2
        
        w=choice([x, y])
        
        f(x,y,z)=choice([
                w/(randint(1,5)^2*z+1),
                randint(1,5)*sin(randint(1,5)*z),
                randint(1,5)*cos(randint(1,5)*z),
                w*randint(1,5)*(randint(1,5)*z)^(1/2),
                randint(1,5)*e^(randint(1,5)*z),
                
            ])
        
        g(r, theta)=f(r*cos(theta), r*sin(theta), r^2)*r
        
        
       

        
        integ = definite_integral( definite_integral( g(r, theta), theta, theta1, theta2 ), r, 0, radius )

        return {
            "f": f(x,y,pythag),
            "g": g(r, theta),
            "x1": x1,
            "x2": x2,
            "y1": y1,
            "y2": y2,
            "theta1": theta1,
            "theta2": theta2,
            "integ": integ,
            "radius": radius,
        }
