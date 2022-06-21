import random
import numpy
import re

class Generator(BaseGenerator):
    def data(self):
        var('x y')
        
        p = [randint(1,2)*choice([-1,1]),randint(1,2)*choice([-1,1])]
        
        [k,l,m] = [0,0,0]
        while(k*l*m == 0):
            [k,l,m] = [randint(1,4)*choice([-1,1]),randint(1,4),randint(1,4)*choice([-1,1])]
        exprs = [x^2*y, x*y^2, x^2, x*y, y^2, x, y]
 
        d=1
        q=0
        if(choice([True,False])):
            l=0
        else:
            m=0

        while(d==1 and q < 10): # Try up to 10 times to get an example w/ gcd > 1
            
            ix = [choice([0,1])]
            ix.append(ix[0]+choice([1,2,3]))
            ix.append(ix[1]+choice([1,2]))

            func(x,y) = 0
            for i in range(3):
                func(x,y) = func(x,y) + [k,l,m][i]*exprs[ix[i]]

            surface=func(x,y)
            fx(x,y) = func(x,y).derivative(x)
            fy(x,y) = func(x,y).derivative(y)
            g = [fx(p[0],p[1]),fy(p[0],p[1])]
            d = gcd(g[0],g[1])
            q += 1
        
        # Choose four directions w, xx, yy, z in increasing order of directional derivative, but obvious w/o necessitating computation
        k0 = choice([-1,1])*choice([1,2,3])
        l0 = choice([1,2,3])
        w0 = [k0*g[0]/d,k0*g[1]/d] # Either +/- the gradient
        xx0= [-g[1]*l0/d,g[0]*l0/d] # Perp to gradient
        yy0 = [0,0] # Positive directional derivative but not gradient
        while(g[0]*yy0[0]+g[1]*yy0[1] <= 0 or g[0]*yy0[1]-g[1]*yy0[0] == 0):
            yy0 = [randint(-3,3),randint(-3,3)]
        z0 = [0,0] # Negative directional derivative but not opposite gradient
        while(g[0]*z0[0]+g[1]*z0[1] >= 0 or g[0]*z0[1]-g[1]*z0[0] == 0):
            z0 = [randint(-3,3),randint(-3,3)] 
        dots = [(w0[0]*g[0]+w0[1]*g[1])/sqrt(w0[0]^2+w0[1]^2),(xx0[0]*g[0]+xx0[1]*g[1])/sqrt(xx0[0]^2+xx0[1]^2),(yy0[0]*g[0]+yy0[1]*g[1])/sqrt(yy0[0]^2+yy0[1]^2),(z0[0]*g[0]+z0[1]*g[1])/sqrt(z0[0]^2+z0[1]^2)]
        
        vecs = [w0, xx0, yy0, z0]
        
        z = vecs[numpy.asarray(dots).argmax()]
        vecs.pop(numpy.asarray(dots).argmax())
        dots.pop(numpy.asarray(dots).argmax())
        yy = vecs[numpy.asarray(dots).argmax()]
        vecs.pop(numpy.asarray(dots).argmax())
        dots.pop(numpy.asarray(dots).argmax())
        xx = vecs[numpy.asarray(dots).argmax()]
        vecs.pop(numpy.asarray(dots).argmax())
        dots.pop(numpy.asarray(dots).argmax())
        w = vecs[numpy.asarray(dots).argmax()]
        vecs.pop(numpy.asarray(dots).argmax())
        dots.pop(numpy.asarray(dots).argmax())
        
        [a,b,c,d] = random.sample([xx,yy,z,w],len([xx,yy,z,w]))

        tours = [0]
        if(func(p[0],p[1])!=0):
            for i in range(1,15):
                tours.append(func(p[0],p[1])*i/3)
                tours.append(-func(p[0],p[1])*i/3)
            
        else:
            for i in range(1,15):
                tours.append(func(3,3)*i/3)
                tours.append(-func(3,3)*i/3)
            
        
        tours = [i for i in set(tours)]
        tours.sort()
        
        dw = (g[0]*w[0]+g[1]*w[1])/sqrt(w[0]^2+w[1]^2)
        dx = (g[0]*xx[0]+g[1]*xx[1])/sqrt(xx[0]^2+xx[1]^2)
        dy = (g[0]*yy[0]+g[1]*yy[1])/sqrt(yy[0]^2+yy[1]^2)
        dz = (g[0]*z[0]+g[1]*z[1])/sqrt(z[0]^2+z[1]^2)

        
        
        return {
            "f": func(x,y),
            "x0": p[0],
            "y0": p[1],
            "a0": a[0],
            "b0": a[1],
            "a1": b[0],
            "b1": b[1],
            "a2": c[0],
            "b2": c[1],
            "a3": d[0],
            "b3": d[1],
            "u0": w[0],
            "v0": w[1],
            "u1": xx[0],
            "v1": xx[1],
            "u2": yy[0],
            "v2": yy[1],
            "u3": z[0],
            "v3": z[1],
            "surface": surface,
            "fx": fx(x,y),
            "fy": fy(x,y),
            "fx0": fx(p[0],p[1]),
            "fy0": fy(p[0],p[1]),
            "w0": w0,
            "g": g,
            "xx0": xx0,
            "yy0": yy0,
            "z0": z0,
            "tours": tuple(tours),
            "dw": dw,
            "dx": dx,
            "dy": dy,
            "dz": dz
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                "contour": contour_plot(data['surface'], (x,-3,3), (y,-3,3), fill=False, label_fmt="%1.0f", label_fontsize=11, label_inline=True, plot_points=400, labels=True, contours=data['tours'])+point2d((data['x0'],data['y0']),size=30,color='red')+text('$P$',(data['x0'],data['y0']),color='red',horizontal_alignment='left',vertical_alignment="top",fontsize=14)
               }

