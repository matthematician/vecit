class Generator(BaseGenerator):
    def data(self):
        var('x y')
    
        
        
        #Differentiable
        
        n1 = randint(1,5)*2
        denom1 = x^n1 + y^n1
        t11=0
        t12=0
        while t11==t12:
            t11 = x^n1*x^randint(1,3)*y^randint(1,3)
            t12 = y^n1*x^randint(1,3)*y^randint(1,3)
        coeff=[1,2,3,4,5]
        shuffle(coeff)
        t11 =t11*choice([-1,1])*coeff[0]
        t12 =t12*choice([-1,1])*coeff[1]    
        num1 = t11 + t12
        
        
        
        #Not Differentiable
        
        n2 = randint(1,5)*2
        denom2 = x^n2 + y^n2
        t21=0
        t22=0
        while t21==t22:
            k1 = randint(1, n2)
            k2 = randint(1, n2)
            
            t21 = x^k1*y^(n2+1-k1)
            t22 = x^k2*y^(n2+1-k2)
        coeff=[1,2,3,4,5]
        shuffle(coeff)
        t21 =t21*choice([-1,1])*coeff[0]
        t22 =t22*choice([-1,1])*coeff[1]
        num2 = t21 + t22
        
        scenario = choice(["firstdiff","seconddiff"])
        
        if scenario == "firstdiff":
            return {
                scenario:True,
                "n1":n1,
                "n2":n2,
                
                "t11":t11,
                "t21":t21,
                
                "t12":t12,
                "t22":t22,
                
                "num1":num1,
                "num2":num2,
                
                "denom1":denom1,
                "denom2":denom2,
            }
        
        if scenario == "seconddiff":
            return {
                scenario:True,
                "n1":n2,
                "n2":n1,
                
                "t11":t21,
                "t21":t11,
                
                "t12":t22,
                "t22":t12,
                
                "num1":num2,
                "num2":num1,
                
                "denom1":denom2,
                "denom2":denom1,
            }
        

    #@provide_data
    #def graphics(data):
        # updated by clontz
    #    return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
    #            "contour": contour_plot(data['surface'], (x,data['min'],data['max']), (y,data['ymin'],data['ymax']), fill=False, plot_points=400, #labels=True, contours=data['tours'])+point2d(data['c2'],size=30,rgbcolor=(0.5,0,0))
    #           }

