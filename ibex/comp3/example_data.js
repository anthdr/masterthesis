

// To set the counterbalancing variable. Below is an example of four conditions (0, 1, 2, 3):

//var counterOverride = 0;
// var counterOverride = 1;
// var counterOverride = 2;
// var counterOverride = 3;

var shuffleSequence = seq("intro", rshuffle("practice"), "sep", rshuffle(rshuffle("stat_low", "stat_high"), rshuffle("filler", "FM")));
var practiceItemTypes = ["practice"];


var defaults = [
    "Separator", {
        transfer: 2000,
        normalMessage: "La session d'entraÃ®nement est terminée. L'expérience commencera dans quelques instants.",
        errorMessage: "La session d'entraÃ®nement est terminée. L'expérience commencera dans quelques instants."
    },
    "DashedSentence", {
        mode: "self-paced reading"
    },
    "AcceptabilityJudgment", {
        presentAsScale: false,
        instructions: "Utiliza las teclas de los nÃºmeros 1 y 2 para contestar.",
        leftComment: "(Bad)", rightComment: "(Good)"
    },
    "Question", {
        hasCorrect: true
    },
    "Message", {
        hideProgressBar: true
    },
    "Form", {
        showProgressBar: false,
        continueOnReturn: true,
        saveReactionTime: true,
    },

"completion", {

        saveReactionTime: true,
    }
];

var items = [



    ["sep", "Separator", { }],
["setcounter", "__SetCounter__", { }],

    ["intro", "completion", {
        html: { include: "intro.html" },
        validators: {
            age: function (s) { if (s.match(/^\d+$/)) return true; else return "Bad value for \u2018age\u2019"; }
        }
    } ],

    [["practice",    102    ], "completion", { html:  '   La boulangerie est fermé le <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    103    ], "completion", { html:  '   Les pommes vertes sont <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    101    ], "completion", { html:  '   Les soldats partent à la guerre sans <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    31    ], "completion", { html:  '    8+72-4 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    32    ], "completion", { html:  '    90-54+6+1 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    33    ], "completion", { html:  '    3+(4-2)+23 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    34    ], "completion", { html:  '    10-5+22-10 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    35    ], "completion", { html:  '    30-(1+1)-7 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],  

[["stat_low",1],"completion", { html:'94-3+(4*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Grégoire a collaboré avec les avocats de l’acteur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",1],"completion", { html:'94-((3+4)*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Grégoire a collaboré avec les avocats de l’acteur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",2],"completion", { html:'98-2+(5*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Pierre a couru avec les amis de l’athlète qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",2],"completion", { html:'98-((2+5)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Pierre a couru avec les amis de l’athlète qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",3],"completion", { html:'94-3+(4*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Sandra a bavardé avec les jardiniers du millionnaire qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",3],"completion", { html:'94-((3+4)*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Sandra a bavardé avec les jardiniers du millionnaire qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",4],"completion", { html:'80-2+(3*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Joel a travaillé avec les stylistes de la célébrité qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",4],"completion", { html:'80-((2+3)*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Joel a travaillé avec les stylistes de la célébrité qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",5],"completion", { html:'97-5+(3*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Tina a étudié avec les médecins du mannequin qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",5],"completion", { html:'97-((5+3)*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Tina a étudié avec les médecins du mannequin qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",6],"completion", { html:'98-2+(5*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Christophe a pardonné les sbires du dictateur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",6],"completion", { html:'98-((2+5)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Christophe a pardonné les sbires du dictateur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",7],"completion", { html:'97-4+(5*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Stéphane a dansé avec les fans du chanteur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",7],"completion", { html:'97-((4+5)*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Stéphane a dansé avec les fans du chanteur qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",8],"completion", { html:'90-5+(3*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Christian a partagé avec le père des étudiants qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",8],"completion", { html:'90-((5+3)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Christian a partagé avec le père des étudiants qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",9],"completion", { html:'84-4+(5*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  George a divorcé du représentant des employés qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",9],"completion", { html:'84-((4+5)*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  George a divorcé du représentant des employés qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",10],"completion", { html:'82-4+(5*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Paul est sorti avec le coach des cheerleaders qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",10],"completion", { html:'82-((4+5)*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Paul est sorti avec le coach des cheerleaders qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",11],"completion", { html:'80-3+(5*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Franck a logé chez les invités de la mariée qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",11],"completion", { html:'80-((3+5)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Franck a logé chez les invités de la mariée qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",12],"completion", { html:'87-3+(5*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Sarah a aimé le promoteur des musiciens qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",12],"completion", { html:'87-((3+5)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Sarah a aimé le promoteur des musiciens qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",13],"completion", { html:'90-4+(5*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Lucie a dîné avec le maître des élèves qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",13],"completion", { html:'90-((4+5)*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Lucie a dîné avec le maître des élèves qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",14],"completion", { html:'98-2+(4*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Jeanne a marché avec le meneur des manifestants qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",14],"completion", { html:'98-((2+4)*3)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Jeanne a marché avec le meneur des manifestants qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",15],"completion", { html:'93-5+(4*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Melissa a hebergé les filles du voisin qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",15],"completion", { html:'93-((5+4)*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Melissa a hebergé les filles du voisin qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",16],"completion", { html:'90-4+(3*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Adrien a entraîné les assistants du PDG qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",16],"completion", { html:'90-((4+3)*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Adrien a entraîné les assistants du PDG qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",17],"completion", { html:'93-3+(4*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Alban a connu les comptables du ministre qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",17],"completion", { html:'93-((3+4)*2)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Alban a connu les comptables du ministre qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",18],"completion", { html:'89-2+(3*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Louis a employé le manager des acteurs qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",18],"completion", { html:'89-((2+3)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Louis a employé le manager des acteurs qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",19],"completion", { html:'89-2+(4*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Carl a sympathisé avec l’agent des chanteurs qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",19],"completion", { html:'89-((2+4)*5)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Carl a sympathisé avec l’agent des chanteurs qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_low",20],"completion", { html:'83-3+(5*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Rayan a vécu avec le capitaine des marins qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],
[["stat_high",20],"completion", { html:'83-((3+5)*4)= <input name="in" type="text" size="60" class="obligatory"  /> . '}, "completion", { html:  '  Rayan a vécu avec le capitaine des marins qui<input name="in" type="text" size="60" class="obligatory"  /> . '  }],


[["FM",    31    ], "completion", { html:  '    7+10-4 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    32    ], "completion", { html:  '    11-2+6-3 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    33    ], "completion", { html:  '    27-(8+1)-9 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    34    ], "completion", { html:  '    73-50+5=    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    35    ], "completion", { html:  '    3+8-7=    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    36    ], "completion", { html:  '    13+(20-1)-8 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    37    ], "completion", { html:  '    6-4+5 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    38    ], "completion", { html:  '    17+11-7 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    39    ], "completion", { html:  '    15+7+3 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    40    ], "completion", { html:  '    16-7+6 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],

[["filler",    60    ], "completion", { html:  '    Le moniteur de kayak prépare <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    61    ], "completion", { html:  '    La pétanque est un sport de <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    62    ], "completion", { html:  '    Le rock est <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    63    ], "completion", { html:  '    Hier, tu as commandé des <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    64    ], "completion", { html:  '    Demain, je vais au <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    65    ], "completion", { html:  '    Maintenant, le musicien commence <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    66    ], "completion", { html:  '    Malheureusement, le conseiller dénigre <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    67    ], "completion", { html:  '    Les pilotes suivent <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    68    ], "completion", { html:  '    Les pompiers se préparent pour <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    69    ], "completion", { html:  '    Les sportifs vont <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],





];


      var MAX_PARTICIPANTS = 40;
function modifyRunningOrder(ro) {
    if (__counter_value_from_server__ >= MAX_PARTICIPANTS) {
             alert("Cette partie de l'expérience est terminée (déjà assez de participants). Merci de cliquer sur le lien suivant. Merci!");
      document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/antoineh/m2-comp2/experiment.html"> Cliquez ici svp pour la Partie II </a> </p>');
   //  document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/chevaleret/ContJust4_c/experiment.html">Cliquez ici svp pour la Partie III </a> </p>');
    // document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/chevaleret/ContJust4_d/experiment.html"> Cliquez ici svp pour la Partie IV </a> </p>');
        // alert("Cette expérience est terminée. Merci.");
        throw "";
    }
    else {
        return ro;
    }
}