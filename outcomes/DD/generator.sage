import random
import numpy
import re

class Generator(BaseGenerator):
    def data(self):
        var('x y z')
        
        
        #pick a point
        x0=choice([-1,1])*randint(1,3)
        y0=choice([-1,1])*randint(1,3)
        z0=choice([-1,1])*randint(1,3)
        
        a=randint(1,5)
        b=randint(1,5)
        c=randint(1,5)
        
        #pick a type of surfcae
        surfacetype=choice(['ellipsoid', 'conetype', 'parabloidtype'])
        
        if surfacetype=='ellipsoid':
            F=a*x^2+b*y^2+c*z^2
            Fun(x,y,z)=F
            k=Fun(x0,y0,z0)
            surfacename='ellipsoid'
            
            
        if surfacetype=='conetype':
            tempcoeff=choice([[1,1,-1],[1,-1,1],[-1,1,1]])
            
            F=a*tempcoeff[0]*x^2+b*tempcoeff[1]*y^2+c*tempcoeff[2]*z^2
            Fun(x,y,z)=F
            k=Fun(x0,y0,z0)
            if k==0:
                surfacename='cone'
            if k>0:
                surfacename='hyperboloid of one sheet'
            if k<0:
                surfacename='hyperboloid of two sheets'    
            
        if surfacetype=='parabloidtype':
            varvec=[x,y,z]
            shuffle(varvec)
            surfacename=choice(['elliptic paraboloid', 'hyperbolic paraboloid'])
            if surfacename=='elliptic paraboloid':
                F=a*varvec[0]^2+b*varvec[1]^2-c*varvec[2]
            if surfacename=='hyperbolic paraboloid':
                F=a*varvec[0]^2-b*varvec[1]^2-c*varvec[2]
            Fun(x,y,z)=F
            k=Fun(x0,y0,z0)
            
        dx=derivative(F,x) 
        dy=derivative(F,y)
        dz=derivative(F,z)
        
        dxf(x,y,z)=dx
        dyf(x,y,z)=dy
        dzf(x,y,z)=dz
        
        dx0=dxf(x0,y0,z0)
        dy0=dyf(x0,y0,z0)
        dz0=dzf(x0,y0,z0)
        
        plane=dx0*(x-x0)+dy0*(y-y0)+dz0*(z-z0)
        
        
        return {
            "x0": x0,
            "y0": y0,
            "z0": z0,
            "F": F,
            "k": k,
            "surfacename": surfacename,
            "dx": dx,
            "dy": dy,
            "dz": dz,
            "dx0": dx0,
            "dy0": dy0,
            "dz0": dz0,
            "plane": plane,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                "surface": implicit_plot3d(data['F']==data['k'], (x,-5,5), (y,-5,5), (z,-5,5), axes=True),
                "planeplot": implicit_plot3d(data['F']==data['k'], (x,-5,5), (y,-5,5), (z,-5,5), axes=True)+implicit_plot3d(data['plane']==0, (x,-5,5), (y,-5,5), (z,-5,5), color="red", opacity=0.5),
               }

