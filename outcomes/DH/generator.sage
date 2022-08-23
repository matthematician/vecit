class Generator(BaseGenerator):
    def data(self):
        var('x y h')
    
        
        
        
        
        
        
        #Not Differentiable
        
        n = randint(1,6)*2
        denom = x^n + y^n
        
        coeff=[-5,-4,-3,-2,-1,0,1,2,3,4,5]
        
        shuffle(coeff)
        
        a=coeff[0]
        b=coeff[1]
        
        k1=0
        k2=0
        
        while k1+k2<n+1:
            k1 = randint(2, n)
            k2 = randint(2, n)
            
        
        num = a*x*y^(n+1)+b*x^(n+1)*y+randint(-5,5)*x^k1*y^k2
        
        f(x,y)=num/denom
        
        fx(x,y)=f(x,y).diff(x)
        fy(x,y)=f(x,y).diff(y)
        
        scenario = choice(["firstdiff","seconddiff"])
        
        return{
            "f":f(x,y),
            "fx":fx(x,y),
            "fy":fy(x,y),
            "fxh":fx(0,h),
            "fyh":fy(h,0),
            "a":a,
            "b":b,
            }
        

    #@provide_data
    #def graphics(data):
        # updated by clontz
    #    return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
    #            "contour": contour_plot(data['surface'], (x,data['min'],data['max']), (y,data['ymin'],data['ymax']), fill=False, plot_points=400, #labels=True, contours=data['tours'])+point2d(data['c2'],size=30,rgbcolor=(0.5,0,0))
    #           }

