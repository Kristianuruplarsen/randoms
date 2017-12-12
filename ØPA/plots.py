# Plots til kapitel 17

import seaborn as sns
import matplotlib.pyplot as plt
import os

os.chdir('C:/Users/qsd161/Documents/GitHub/randoms/ØPA/img')


DPI = 300

#### opgave 1
# a)
def cleanplot():
    plt.plot([0,10,20,30,40], [70,60,45,25,0],
        color = "b",
        marker = "o")
    plt.title("Transformationskurve")
    plt.xlabel("Biler")
    plt.ylabel("Brød")
    plt.savefig('clean.png', dpi = DPI)
    plt.show()


def stepplot(x,y, title):
    plt.step(x,y, color = "r")
    plt.plot([0,10,20,30,40], [70,60,45,25,0],
        color = "b",
        marker = "o")
    plt.title("Transformationskurve")
    plt.xlabel("Biler")
    plt.ylabel("Brød")
    plt.savefig(title,dpi = DPI)
    plt.show()

cleanplot()
stepplot([0,10],[70,60], "step1.png")
stepplot([30,40],[25,0], "step2.png")


#c)

def innovations():
    plt.plot([0,10,20,30,40], [90,75,55,30,0],
        color = "purple",
        marker = "o",
        label = "Med innovation")
    plt.plot([0,10,20,30,40], [70,60,45,25,0],
        color = "b",
        marker = "o",
        label = "Uden innovation")
    plt.title("Transformationskurve (ny brød-teknologi)")
    plt.xlabel("Biler")
    plt.ylabel("Brød")
    plt.legend()
    plt.savefig('innov.png', dpi = DPI)
    plt.show()

innovations()


#d)
def unemployment():
    plt.plot([0,10,20,30,40], [70,60,45,25,0],
        color = "b",
        marker = "o",
        label = "Mulig produktion",
        zorder = 0)
    plt.scatter([20, 20*0.9, 0], [45, 45*0.9, 0],
        label = "Faktisk produktion",
        color = "r",
        zorder = 10)
    plt.title("Produktion ved forskellige arbejdsløshedsniveauer")
    plt.xlabel("Biler")
    plt.ylabel("Brød")
    plt.legend()
    plt.savefig('unemp.png', dpi = DPI)
    plt.show()

unemployment()



### Opgave 2+3
def komparative(a1, a2, x, y, fnm):
    f, (ax1, ax2) = plt.subplots(1, 2, sharey=True, sharex = True)
    ax1.plot([4,0], [0,2],
    color = "b")
    ax1.set_title(a1)
    ax2.plot([2,0], [0,6],
    color = "b")
    ax2.set_title(a2)
    ax1.set_xlabel(x)
    ax1.set_ylabel(y)
    ax2.set_xlabel(x)
    ax2.set_ylabel(y)
    plt.axis(xmin=0,xmax=4,ymin=0,ymax=6)
    plt.savefig(fnm, dpi = DPI)
    plt.show()


#a)
komparative("Peter", "Hans", "vand", "rugbrød", "comp1")




def komparative2(fnm, solve = False):
    plt.plot( [0, 4] , [2, 0],
        color = "b",
        label = "Peter")
    plt.plot( [0, 2] , [6, 0],
        color = "r",
        label = "Hans")
    plt.scatter([1, 1], [3, 1.5],
    label = "Udgangspunkt", zorder = 10)
    if solve:
        plt.arrow(1,3,0.5,-1)
        plt.arrow(1,1.5, -0.5, 1)
#    plt.title("Transformationskurve")
    plt.xlabel("vand")
    plt.ylabel("Rugrød")
    plt.legend()
    plt.axis(xmin=0,xmax=4,ymin=0,ymax=6)
    plt.savefig(fnm, dpi = DPI)
    plt.show()

komparative2('komp2.png', solve = False)
komparative2('komp2_solve.png', solve = True)


### opgave 5
# ideally this should take coordinates as arguments, byt as im
# in a hurry, it's being copy pasted instead
def komparative(a1, a2, x, y, fnm):
    f, (ax1, ax2) = plt.subplots(1, 2, sharey=True, sharex = True)
    ax1.plot([0, 2*6], [6*1, 0],
    color = "b")
    ax1.set_title(a1)
    ax2.plot([0, 6*1], [6*2, 0],
    color = "b")
    ax2.set_title(a2)
    ax1.set_xlabel(x)
    ax1.set_ylabel(y)
    ax2.set_xlabel(x)
    ax2.set_ylabel(y)
    plt.axis(xmin=0,xmax=12,ymin=0,ymax=12)
    plt.savefig(fnm, dpi = DPI)
    plt.show()

komparative('Helle', 'Anders', 'Kartofler', 'Fisk', 'comp2.png')

def komparative_fourtyfive(a1, a2, x, y, fnm, arrow = False):
    f, (ax1, ax2) = plt.subplots(1, 2, sharey=True, sharex = True)
    ax1.plot([0, 2*6], [6*1, 0],
    color = "b")
    if arrow:
        ax1.plot([0, 2*6], [6*2, 0],
        color = "navy")
        ax1.arrow(4,4,1,1,zorder = 20, head_width=0.5, head_length=1, fc='k', ec='k')
    ax1.set_title(a1)
    ax2.plot([0, 6*1], [6*2, 0],
    color = "b")
    if arrow:
        ax2.plot([0, 2*6], [6*2, 0],
        color = "navy")
        ax2.arrow(4,4,1,1,zorder = 20, head_width=0.5, head_length=1, fc='k', ec='k')
    ax1.plot([0,12],[0,12], 'r--')
    ax2.plot([0,12],[0,12], 'r--')
    ax2.set_title(a2)
    ax1.set_xlabel(x)
    ax1.set_ylabel(y)
    ax2.set_xlabel(x)
    ax2.set_ylabel(y)
    plt.axis(xmin=0,xmax=12,ymin=0,ymax=12)
#    plt.subplots_adjust(left=0, bottom=0, right=1, top=1, wspace=0, hspace=0)
    plt.savefig(fnm, dpi = DPI)
    plt.show()
#a)


komparative_fourtyfive('Helle', 'Anders', 'Kartofler', 'Fisk', 'comp2_analysis.png')

komparative_fourtyfive('Helle', 'Anders', 'Kartofler', 'Fisk', 'comp2_analysis_arrow.png', arrow = True)
