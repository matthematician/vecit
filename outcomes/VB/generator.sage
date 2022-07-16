class Generator(BaseGenerator):
    def data(self):
        var('x y t')
        
        poly=randint(-1,3)*x^randint(1,3)*y^randint(1,3)
        
        px=randint(1,3)
        py=randint(1,3)
        c=randint(1,3)*choice([-1,1])
        
        Fchoices=([c*e^(x^px+y^py)+poly, c*x*e^(y^py)+poly, c*y*e^(x^px)+poly])
        shuffle(Fchoices)
        
        F(x,y)=Fchoices[0]
        
        f=(Fchoices[0].derivative(x), Fchoices[0].derivative(y))
        f0=(Fchoices[0].derivative(x), Fchoices[0].derivative(y))
        f1=(Fchoices[1].derivative(x), Fchoices[2].derivative(y))
        
        Fi=[f0, f1]
        
        shuffle(Fi)
        f0=Fi[0]
        f1=Fi[1]
        
        P=(0,0)
        Q=(0,0)
        
        while P==Q:
            P=(randint(-5,5), randint(-5,5))
            Q=(randint(-5,5), randint(-5,5))
        
        
        integ=F(Q[0], Q[1])-F(P[0], P[1])
        
        
        return {
            "fx": f[0],
            "fy": f[1],
            "f0x": f0[0],
            "f0y": f0[1],
            "f1x": f1[0],
            "f1y": f1[1],
            "P": P,
            "Q": Q,
            "FP": F(P[0],P[1]),
            "FQ": F(Q[0], Q[1]),
            "F": F(x,y),
            "integ": integ,
            
            
        }
    
    
