class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        
        
        
        #pick a function
        
        funcxy=choice([
                x^randint(1,5)*y^randint(1,5),
                (x^randint(1,5)+y^randint(1,5))^(1/2),
                exp(x^randint(1,5)*y^randint(1,5)),
                exp(x^randint(1,5)+y^randint(1,5)),
                sin(x^randint(1,5)*y^randint(1,5)),
                sin(x^randint(1,5)+y^randint(1,5)),
                cos(x^randint(1,5)*y^randint(1,5)),
                cos(x^randint(1,5)+y^randint(1,5)),
                x^randint(1,5)*exp(y^randint(1,5)),
                x^randint(1,5)*cos(y^randint(1,5)),
                x^randint(1,5)*sin(y^randint(1,5)),
                y^randint(1,5)*exp(x^randint(1,5)),
                y^randint(1,5)*cos(x^randint(1,5)),
                y^randint(1,5)*sin(x^randint(1,5)),
                x^randint(1,5)/y^randint(1,5),
                y^randint(1,5)/x^randint(1,5),
                1/(x^randint(1,5)+y^randint(1,5)),
                log(x^randint(1,5)+y^randint(1,5)),
            ])
        
        funcx=choice([
                x^(randint(1,5)*choice([-1,1])),
                exp(x^randint(1,5)),
                sin(x^randint(1,5)),
                cos(x^randint(1,5)),
            ])
        
        funcy=choice([
                y^(randint(1,5)*choice([-1,1])),
                exp(y^randint(1,5)),
                sin(y^randint(1,5)),
                cos(y^randint(1,5)),
            ])
        
        f=randint(1,5)*choice([-1,1])*funcxy+randint(1,5)*choice([-1,1])*funcx+randint(1,5)*choice([-1,1])*funcy
        
        fx=derivative(f,x)
        fy=derivative(f,y)
        fxx=derivative(fx,x)
        fxy=derivative(fx,y)
        fyx=derivative(fy,x)
        fyy=derivative(fy,y)
        
        
        
        
        
        
        
        
        
        return {
            "f": f,
            "fx": fx,
            "fy": fy,
            "fxx": fxx,
            "fxy": fxy,
            "fyx": fyx,
            "fyy": fyy,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

