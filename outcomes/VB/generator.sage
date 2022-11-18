class Generator(BaseGenerator):
    def data(self):
        var('x y t')
        
        poly=randint(-1,3)*x^randint(1,3)*y^randint(1,3)
        
        px=randint(1,3)
        py=randint(1,3)
        c=randint(1,3)*choice([-1,1])
        
        trigchoice = [sin(x), cos(x)]
        shuffle(trigchoice)
        
        Fchoices= [poly, c*x*e^(y^py)+poly, c*y*e^(x^px)+poly]
        shuffle(Fchoices)
        
        F(x,y)=Fchoices[0]
        
        f=(Fchoices[0].derivative(x), Fchoices[0].derivative(y))
        f0=(Fchoices[0].derivative(x), Fchoices[0].derivative(y))
        f1=(Fchoices[1].derivative(x), Fchoices[2].derivative(y))
        
        Fi=[f0, f1]
        
        shuffle(Fi)
        f0=Fi[0]
        f1=Fi[1]
        
        a=0
        b=randint(1,5)
        
        trig=[sin(2*pi*t), cos(2*pi*t)]
        quad = [t^2+randint(-5,5), randint(-3,3)*t+randint(-5,5)]
        
        shuffle(trig)
        shuffle(quad)        
        xt(t)=trig[0]*quad[0]
        yt(t)=trig[1]*quad[1]
        
        P=(xt(a),yt(a))
        Q=(xt(b), yt(b))
        
        while P==Q:
            b=randint(1,5)
            shuffle(trig)
            shuffle(quad)        
            xt(t)=trig[0]*quad[0]
            yt(t)=trig[1]*quad[1]
            
            P=(xt(a),yt(a))
            Q=(xt(b), yt(b))
            
        
        
        integ=F(Q[0], Q[1])-F(P[0], P[1])
        
        
        return {
            "fx": f[0],
            "fy": f[1],
            "f0x": f0[0],
            "f0y": f0[1],
            "f1x": f1[0],
            "f1y": f1[1],
            "xt": xt(t),
            "yt": yt(t),
            "a": a,
            "b": b,
            "P": P,
            "Q": Q,
            "FP": F(P[0],P[1]),
            "FQ": F(Q[0], Q[1]),
            "F": F(x,y),
            "integ": integ,
            
            
        }
    
    
