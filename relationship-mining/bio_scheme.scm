;(ConceptNode "hello world")

; pln/ure helpers
(define cpolicy "opencog/reasoning/bio_cpolicy.json")

; atomspace populating helpers
(define knowledge-dir "../../bio-data/scheme-representations/")
(define subgraph-dir (string-append knowledge-dir "subgraphs/"))

(define (loadf f) (load (string-append knowledge-dir f)))
(define (loadsub f) (load (string-append subgraph-dir f)))

(define (loadGO1K) (loadf "subgraphs/subgraph_1K_GO.scm"))
(define (load1K) (loadf "subgraphs/subgraph_1K.scm"))


; general utility shortcuts and helpers
(define countall count-all)
(define prt cog-prt-atomspace)



; set the truth value for GeneNodes
(define (set_gene_tvs strength confidence)
    (let ([genes (cog-get-atoms 'GeneNode)])
       (map (lambda (gene)       
            (cog-set-tv! gene (cog-new-stv strength confidence))) 
            genes)))

; one-step inference forward chaining algo
; first we could get the incoming links to source and save those as "known"
(define (do_one_steps source)
    (do ((i 1 (1+ i)))
        ((> i 100))
      (cog-fc-em source cpolicy)))
; then we could filter out the previously known to get the "new" knowledge



; one-step inference forward chaining algo with default
(define (do_one_steps_def)
    (do_one_steps (GeneNode "SHANK2")))


(define pattern_match_go_terms
    (BindLink
        (VariableNode "$go")
        (ImplicationLink
            (InheritanceLink
                (VariableNode "$go")
                (ConceptNode "GO_term"))
            (VariableNode "$go"))))

(define (loadtemp)
  (load "temp.scm"))

#|             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define get_go_terms
    (cog-outgoing-set (cog-bind pattern_match_go_terms)))



(define (get_inheritance_child_nodes parent)
    (cog-bind
        (BindLink
            (ListLink
                (VariableNode "$child"))
            (ImplicationLink
                ;(AndLink
                    (InheritanceLink
                        (VariableNode "$child")
                        (ConceptNode parent))
                ;    (NotLink
                ;        (EquivalenceLink
                ;            (VariableNode "$child")
                ;            (ConceptNode "GO_term"))))
                (VariableNode "$child")))))




(define (get_members_of setname)
    (cog-bind
        (BindLink
            (VariableNode "$member") 
            (ImplicationLink
                (MemberLink
                    (VariableNode "$member")
                    (ConceptNode setname))
                (VariableNode "$member")))))


(define (get_sets_for_member membername)
    (cog-bind
        (BindLink
            (VariableNode "$setname")
            (ImplicationLink
                (MemberLink
                    (GeneNode membername)
                    (VariableNode "$setname"))
                (VariableNode "$setname")))))

|#         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(define (test something)
;    (display something))

;(define (set-genenode-tvs)
;    (define genenodes (cog-get-atoms 'GeneNode))



