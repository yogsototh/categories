 ## Introduction

%TODO{Do everything after the end}

Now, it is time to talk about Categories.
How this notion could help you and how it is easy to use with Haskell.

- What are categories?
- How to use them?

 ### Programming Paradigms

When you program, you resolve problems.
There are a lot of different means to resolve a problem.
Many different "school of thought"[^school] exists.

[^school]: Écoles de pensées

**Imperative paradigm**:
In programming, most people use the imperative paradigm.
You have an infinite number of cell and you can write things on them.
Of course, it is more complex with modern architecture, but the paradigm is the same.
Hidden somewhere, there is the model of the Turing machine.

**Functional paradigm**:
Another paradigm, is the functional paradigm.
This time, you don't write on cells, but instead you have a flow of data.
And you transform the flows in another flows... Mostly it looks like pipes.
I am a bit restrictive here. But generally this is how functional programming is perceived.
The main theory behind this paradigm is the Set theory.
You have a set and you go from one set to another set by using a function.

**Category paradigm**:
I believe there is another paradigm arising from Category theory.
Category theory feels both more general and powerful to help solve problems.

First, you must realize there are categories everywhere.
With the category theory you can find relationships between quantum physics,
topology, logic (both predicate and first order), programming.
Most of the time, the object your are programming with will form a category.

This is the promise from the Category Theory.
Another even better paradigm.
A paradigm with gates between many different domains.

 ## Get some intuition

We write down the definition first.
And will discuss about some categories.

<div style="display:none">
\\( \newcommand{\hom}{\mathrm{hom}} \\)
</div>

 > **Definition**:
 >
 > A category \\(C\\) consist of:
 >
 > - A collection of _objects_ \\(ob(C)\\)
 > - For every pair of objects \\((A,B)\\) a set \\(\hom(A,B)\\)
 >   of _morphisms_ \\(f:A→B\\) (Another notation for \\(f\in \hom(A,B)\\))
 > - A composition operator \\(∘\\)
 >   which associate to each couple \\(f:A→B\\), \\(g:B→C\\) another morphism \\(g∘f:A→C\\).
 >
 > With the following properties
 >
 > - for each object \\(x\\) there is an identity morphism  
 >   \\(id_x:x→x\\)  
 >   s.t. for any morphism \\(f:A->B\\),  
 >   \\(id_A∘f = f = f∘id_B\\)
 > - for all triplet of morphisms \\(f:A->B\\), \\(g:B->C\\) and \\(h:C->D\\)  
 >   \\( (h∘g)∘f = h∘(g∘f) \\)
<mpost title="Identity is left and right neutral element for ∘">
z0=origin;
z1=(2gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);

drawLoop(z0,btex $id_A$ etex);
drawLoop(z1,btex $id_B$ etex);

drawEdge(z0,z1,btex $f\circ id_A = f = id_B\circ f$ etex);
</mpost>

<mpost title="Associativity">
z0=origin;
z1=(gu,0);
z2=(2gu,0);
z3=(3gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);
drawState(z3,btex $D$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z2,z3,btex $h$ etex);

drawoptions(withcolor blue);
drawEdgeWithAngle(z0,z2,btex $g\circ f$ etex,30);

drawoptions(withcolor yellow);
drawEdgeWithAngle(z1,z3,btex $h\circ g$ etex,-30);

drawoptions(withcolor red);
drawEdgeWithAngle(z0,z3,btex $(h\circ g)\circ f = h\circ (g\circ f)$ etex,45);
</mpost>

 ### Representation of Category

Representing Category is not just a game.
It will be _very_ important.
But in the same time, it will help you to gain intuition about categories.

A naïve representation (which can work in many cases) is to represent
a specific category as a directed graph.
Here is a first example of the representation of a category:

<mpost title="First Naïve Category Representation">
z0=origin;
z1=2/3(gu,gu);
z2=(4/3gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z0,z2,btex $h$ etex);

drawLoop(z0,btex $id_A$ etex);
drawLoop(z1,btex $id_B$ etex);
drawLoop(z2,btex $id_C$ etex);

</mpost>

From this graph we can conclude without any ambiguity that:

\\[ob(C)=\\{A,B,C\\}\\]
and
\\[\hom(C)=\\{f,g,h,id_A,id_B,id_C\\}\\]

Instantaneously, we understand that we can get rid of all \\(id_i\\) arrows.

But in reality, we lack an important information.
What is \\(∘\\)?

Now, we can add informations to our previous representation.
We simply add a relation between 3 arrows that represent the composition.

<mpost title="Naïve Category Representation">
z0=origin;
z1=(gu,gu);
z2=(2gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z0,z2,btex $h$ etex);

drawoptions( withcolor red );

z3=.6[z0,z1];
z4=.6[z2,z1];

draw z3 -- z4 dashed evenly;

z5 = .45[z3,z4];
z6 = .55[z0,z2];
path bigarrow;
bigarrow := shorten(z5--z6,2bp);
drawarrow bigarrow withpen pencircle scaled 1.5;

label.rt(btex $h = g \circ f$ etex, .5[z5,z6]);

</mpost>

Now we have a complete representation.
We don't have to represent \\(id_i\\), we know there are there.
And we also don't have to represent composition implying \\(id_i\\) morphisms.
But, even this little graph look complex.
To show just how complex things can be;
we just double the number morphisms between different objects.

<mpost title="Naïve Category Representation Mess (∘ representation)">
z0=origin;
z1=(2gu,gu);
z2=(4gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdgeWithAngle(z0,z1,btex $f$ etex,45);
drawEdge(z0,z1,btex $f'$ etex);
drawEdgeWithAngle(z1,z2,btex $g$ etex,45);
drawEdge(z1,z2,btex $g'$ etex);
drawEdgeWithAngle(z0,z2,btex $h$ etex,-10);
drawEdgeWithAngle(z0,z2,btex $h'$ etex,-35);

def drawLink(expr f,g,h,l,propf,propg,proph,propfg) =
    begingroup
        pair midf,midg,midh,midfg;
        midf=point propf of f;
        midg=point propg of g;

        path fg; fg:=midf .. midg;
        draw fg dashed evenly;

        midfg = point propfg of fg;
        midh = point proph of h;
        path bigarrow;
        bigarrow := shorten (midfg .. midh,2bp);
        drawarrow bigarrow  withpen pencircle scaled 1.5;

        label.rt(l, point .5 of bigarrow);
    endgroup;
enddef;

path f,fp,g,gp,h,hp;

f=edgeAngle(z0,z1,45);
fp=edge(z0,z1);
g=edgeAngle(z1,z2,45);
gp=edge(z1,z2);
h=edgeAngle(z0,z2,-10);
hp=edgeAngle(z0,z2,-35);


drawoptions( withcolor red );
drawLink(f,g,h,btex $g\circ f$ etex, .5,.5,.4,.3);
drawoptions( withcolor blue );
drawLink(fp,gp,h,btex $h=g'\circ f'$ etex, .5,.5,.55,.7);
drawoptions( withcolor yellow );
drawLink(f,gp,hp,btex $h'=g'\circ f$ etex, .5,.5,.1,.2);
drawoptions( withcolor green );
drawLink(fp,g,hp,btex $h'=g\circ f'$ etex, .5,.5,.9,.8);

</mpost>

Another representation of the preceding category:

<mpost title="Another representation">
z0=origin;
z1=(2gu,gu);
z2=(4gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdgeWithAngle(z0,z1,btex $f$ etex,45);
drawEdge(z0,z1,btex $f'$ etex);
drawEdgeWithAngle(z1,z2,btex $g$ etex,45);
drawEdge(z1,z2,btex $g'$ etex);
drawEdgeWithAngle(z0,z2,btex $h=g\circ f=g'\circ f'$ etex,-10);
drawEdgeWithAngle(z0,z2,btex $h'=g\circ f'=g'\circ f$ etex,-35);
</mpost>

 ### Examples

Which can be a valid category by choosing ∘ appropriately?
The identity morphisms are assumed.

<mpost title="This can be a valid category">
z0=(0,0);
z1=2(u,0);
z2=2(2u,0);

drawarrow nl_edge(z0,z1);
drawarrow nl_edge(z1,z2);
drawarrow nl_edgeAngle(z0,z2,50);

drawstate(z0);
drawstate(z1);
drawstate(z2);
</mpost>

<mpost title="Cannot be a category; no candidate for g∘f.">
z0=(0,0); z1=3(u,0); z2=3(2u,0);
drawstate(z0); drawstate(z1); drawstate(z2);

drawedge(z0,z1,btex $f$ etex);
drawedge(z1,z2,btex $g$ etex);
</mpost>

<mpost title="Also a possible valid category">
z0=(0,0); z1=(4u,0); z2=(2u,-3u);
drawstate(z0); drawstate(z1); drawstate(z2);

drawarrow nl_edgeAngle(z0,z1,35);
drawarrow nl_edgeAngle(z1,z0,-145);
drawarrow nl_edge(z0,z2);
drawarrow nl_edge(z1,z2);
</mpost>

<mpost title="Not a category; no \(A→C\) while there exists \(A→B\) and \(B→C\)">
z0=(0,0); z1=(gu,0); z2=(.5gu,-.75gu);
drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawarrow edgeAngle(z0,z1,35);
drawarrow edgeAngle(z1,z0,-145);
drawarrow edge(z1,z2);
drawarrow edge(z2,z0);
</mpost>


<mpost title="Cannot be a category ; no possible associative ∘<br/>\((h∘g)∘f=idB∘f=f≠h=h∘idA=h∘(g∘f)\)">
z0=origin;
z1=(gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawEdgeWithAngle(z1,z0,btex $f$ etex,145);
drawEdge(z0,z1,btex $g$ etex);
drawEdgeWithAngle(z1,z0,btex $h$ etex,-145);
</mpost>

To continue to gain some intuition I will give some degenerated Category examples.

 ### Monoids

What are Monoids?
Things that you can operate a list of in any evaluation order and obtain the same result.

More precisely; let `l` be a list of elements of the monoid.
then

<code class="haskell">
foldl (<>) e l = foldr (<>) e l
</code>

Where `(<>)` is the monoid operation.
And `e` is the neutral element of the monoid.
Equivalently:

<code class="haskell">
((e <> x) <> y) <> z = x <> ( y <> ( z <> e) )
</code>

Or another way of saying it is that `x <> y <> z` doesn't need any parenthesis.
Because whatever the order of evaluation the result will be the same.

Typical examples:

- `String` with `(++)` and `""`
- `Lists` with `(++)` and `[]`
- `Data.Text` with `append` and `empty`
- `Integer` with `(+)` and `0`
- `Integer` with `(*)` and `1`
- Generalized by `Monoid a` with `(<>)` and `mempty`

<mpost title="Strings are Categories">
pair A,B,C,D,E,F;
A:=(0,0); B:=(0,u); C:=(0,2u);
D:=(0,3u); E:=(0,4u); F:=(0,6u);

drawloop(A,B,btex $\varepsilon$ etex);
drawloop(A,C,btex $a$ etex);
drawloop(A,D,btex $b$ etex);
drawloop(A,E,btex $ab$ etex);
drawloop(A,F,btex $\omega$ etex);
draw (0,4.8u)--(0,5.8u) dashed withdots;
draw A withpen pencircle scaled 4bp;
</mpost>
