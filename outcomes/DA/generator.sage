class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #Pick a point
        x0=0#randint(-5,5)
        y0=0#randint(-5,5)
        
        
        
        #pick a function that converges
        
        fact=x^randint(0,2)*y^randint(0,2)
        
        connum=(randint(1,5)*choice([-1,1])*x^randint(0,2)*y^randint(0,2)+randint(1,5)*choice([-1,1])*x^randint(0,2)*y^randint(0,2)+randint(-5,5))*fact
        conden=(randint(1,5)*choice([-1,1])*x^randint(1,2)*y^randint(1,2)+randint(1,5)*choice([-1,1])*x^randint(1,2)*y^randint(0,2)+randint(1,5))*fact
        
        con(x,y)=connum/conden
        
        conlim=con(x0,y0)
        
        #pick a function which diverges
        
        limx=0
        limy=0
        
        a=0
        b=1
        c=0
        d=1
        
        while(a/b==c/d):
            b=randint(1,5)*choice([-1,1])
            a=randint(1,5)*choice([-1,1])
        
            d=randint(1,5)*choice([-1,1])
            c=randint(1,5)*choice([-1,1])
        
        
        
        divnum=randint(1,5)*choice([-1,1])*x^2*y^2+a*x+c*y + randint(-5,5)*x^randint(2,4)*y^randint(2,4)
            #
        divden=randint(1,5)*choice([-1,1])*x^2*y^2+b*x+d*y + randint(-5,5)*x^randint(2,4)*y^randint(2,4)
            #
        div(x,y)=divnum/divden
        divx=div(x,0)
        limx=divx.limit(x=0)
        divy=div(0,y)
        limy=limit(divy, y=0)
        divt=div(t,t)
        limt=limit(divt, t=0)
            
        
        
        
        
        
        
        
        
        
        
        
        return {
            "x0": x0,
            "y0": y0,
            "connum": expand(connum),
            "conden": expand(conden),
            "divnum": expand(divnum),
            "divden": expand(divden),
            "limx": limx,
            "limy": limy,
            "limt": limt,
            "conlim": conlim,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

