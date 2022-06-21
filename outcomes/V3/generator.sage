class Generator(BaseGenerator):
    def data(self):
        var('x t y')
        k = 3*randint(1,4)
        h(x,y) = x^4 - k*x^2 + y^2 +randint(-24,24)
        if(choice([True,False])):
            [hxe,hye] = [h(x,y).derivative(x), h(x,y).derivative(y)]
            hh(x,y) = h(x,y)
        else:
            [hxe,hye] = [h(y,x).derivative(x), h(y,x).derivative(y)]
            hh(x,y) = h(y,x)

            
            
        hx(x,y) = hxe
        hy(x,y) = hye
            
        P=vector([0,0])
        Q=vector([0,0])
        while(P==Q):
            P = vector([randint(-4,4),randint(-4,4)])
            Q = vector([randint(-4,4),randint(-4,4)])
        
        # Parametrize a fun curve from P to Q
        nor = (Q-P)/(Q-P).norm()
        j = randint(1,4)
        r = [(1-t)*P[0]+t*Q[0]+(t^3-t)*sin(j*pi*t)*nor[1],(1-t)*P[1]+t*Q[1]-(t^3-t)*sin(j*pi*t)*nor[0]]
        
        
        # Decide on contour levels by including h(P) and h(Q) on the way from zmin to zmax.
        
        [zp,zq]=[hh(P[0],P[1]),hh(Q[0],Q[1])]
        [gp,gq]=[hx(P[0],P[1])^2+hy(P[0],P[1])^2,hx(Q[0],Q[1])^2+hy(Q[0],Q[1])^2]
        if(zp==zq):
            d = 16
            s = zp-16
        else:
            d = abs(zq-zp)/4
            if(gp > gq):
                s = zq
            else:
                s = zp
        #tours = [s+k^2*d for k in range(0,6)]+[s-d]
        tours = [zp,zq]
        tours = [i for i in set(tours)]
        tours.sort()
        
        #Pick a potential function and make its gradient and its perp-gradient
        
        [m,n] = [randint(1,5), choice([-1,1])*randint(1,3)]
        
        funcs = [
            m*x^2*y + n*x,
            m*x*y^2 + n*y,
            n*x^m*y + m*y,
            n*y^m*x + m*x,
        ]
        
        shuffle(funcs)
        
        a(x,y) = funcs[0]
        b(x,y) = a(y,x)
        
        pp=vector([0,0])
        qq=vector([0,0])
        while( pp==qq ):
            pp=vector([randint(-4,4),randint(-4,4)])
            qq=vector([randint(-4,4),randint(-4,4)])
        
        if(choice([True,False])):
            fx(x,y) = a(x,y).derivative(x)
            fy(x,y) = a(x,y).derivative(y)
            gx(x,y) = b(x,y).derivative(y)
            gy(x,y) = b(x,y).derivative(x)
            [gradd,ngrad] = ["F","G"]
            scurl = gy(x,y).derivative(x) - gx(x,y).derivative(y)
            deltaf = a(qq[0],qq[1]) - a(pp[0],pp[1])
        else:
            gx(x,y) = a(x,y).derivative(x)
            gy(x,y) = a(x,y).derivative(y)
            fx(x,y) = b(x,y).derivative(y)
            fy(x,y) = b(x,y).derivative(x)
            [gradd,ngrad] = ["G","F"]
            scurl = fy(x,y).derivative(x) - fx(x,y).derivative(y)
            deltaf = b(qq[0],qq[1]) - b(pp[0],pp[1])

            
            
        
        
        
        return {
            "grad": gradd,
            "ngrad": ngrad,
            "hx": hx(x,y),
            "hy": hy(x,y),
            "h": hh(x,y),
            "p": P,
            "q": Q,
            "tours": tuple(tours),
            "deltah": zq-zp,
            "r": tuple(r),
            "fx": fx(x,y),
            "fy": fy(x,y),
            "gx": gx(x,y),
            "gy": gy(x,y),
            "scurl": scurl,
            "a": pp,
            "b": qq,
            "deltaf": deltaf
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {"plot": plot_vector_field((data['hx'],data['hy']),(x,-5,5),(y,-5,5), color="gray")+contour_plot(data['h'], (x,-5,5),(y,-5,5), labels=True, fill=False, linewidths=0.5, label_fontsize=11, label_fmt=lambda x: "$%1.0f$"%x, contours=data['tours'], color='black',label_inline=True)+point(data['p'],size=32,color='red')+point(data['q'],size=32,color='red')+text("$P$",data['p'],color='red',horizontal_alignment="left",vertical_alignment="top")+text("$Q$",data['q'],color='red',horizontal_alignment="left",vertical_alignment="top")+parametric_plot(data['r'],(t,0,1),color='red')
            }