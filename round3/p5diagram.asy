import three;
unitsize(1cm);
size(200);
defaultpen(fontsize(6pt));
currentprojection=TopView;

triple O = (0,0,0);

triple A = (cos(radians(120)), sin(radians(120)), 0);
triple B = (cos(radians(210)), sin(radians(210)), 0);
triple C = (cos(radians(330)), sin(radians(330)), 0);
triple H = (A + B + C);

triple P = (H.x, H.y, sqrt((1 - abs(H)^2)/2));
triple Pp = (H.x, H.y, -sqrt((1 - abs(H)^2)/2));
label("$H$", align=2N, H);
label("$P'$", align=-2N, Pp);
dot(Pp); dot(H);
label("$P$", align=2N, P);
dot(P);

draw(A--P, gray(0.2)); draw(B--P, gray(0.2)); draw(C--P, gray(0.2));
draw(A--Pp, gray(0.2)); draw(B--Pp, gray(0.2)); draw(C--Pp, gray(0.2));

surface midpoint_sphere(triple x, triple y) {
  return shift((x+y)/2) * scale3(abs((x-y)/2)) * unitsphere;
}

draw(A--B--C--cycle);

draw(midpoint_sphere(A,B), opacity(0.3)+red,nolight);
draw(midpoint_sphere(B,C), opacity(0.3)+green,nolight);
draw(midpoint_sphere(A,C), opacity(0.3)+blue,nolight);

real BOUNDARY = 1.8;
draw(O--(BOUNDARY,0,0), gray,Arrow3);
draw(O--(-BOUNDARY,0,0), gray,Arrow3);

draw(O--(0,-BOUNDARY,0), gray,Arrow3);
draw(O--(0,BOUNDARY,0), gray,Arrow3);

draw(O--(0,0,BOUNDARY), gray,Arrow3);
draw(O--(0,0,-BOUNDARY), gray,Arrow3);

surface solution = zscale3(1/sqrt(2)) * unitsphere;
draw(solution, opacity(0.4)+gray,currentlight);
path3 g=(1,0,0)..(0,1,0)..(-1,0,0)..(0,-1,0)..cycle;
draw(g, white);


label("$(0,0,\frac{1}{\sqrt{2}})$", align=2N, (0,0,1/sqrt(2)));
label("$(0,0,-\frac{1}{\sqrt{2}})$", align=-2N, (0,0,-1/sqrt(2)));
dot((0,0,1/sqrt(2)), gray(0.2));
dot((0,0,-1/sqrt(2)), gray(0.2));
label("$A$", align=N, A);
label("$B$", align=N, B);
label("$C$", align=N, C);