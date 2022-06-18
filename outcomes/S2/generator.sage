class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y')
        [a,b] = [choice([-1,1])*randrange(1,9),choice([-1,1])*randrange(1,9)]
        
        expr = randrange(1,5)*2*x*y
        if(choice([True,False])):
            expr += randrange(1,6)*choice([-1,1])*y
        else:
            expr += randrange(1,6)*choice([-1,1])*x
            
        xrange = sorted([0,b])
        yrange = [0,a-a*x/b]
        
        if(a<0):
            yrange.reverse()

        
        integ = definite_integral( definite_integral( expr, y, yrange[0], yrange[1] ), x, xrange[0], xrange[1] )

        return {
            "f": expr,
            "a": a,
            "b": b,
            "xmin": xrange[0],
            "xmax": xrange[1],
            "ymin": yrange[0],
            "ymax": yrange[1],
            "integral": integ
        }
