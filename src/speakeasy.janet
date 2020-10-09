(import ./speakeasy/html :prefix "" :export true)


(defn janet? [s]
  (when (string? s)
    (string/has-suffix? ".janet" s)))


(defn smuggle* [filename]
  (eval-string (string "(use speakeasy)\n"
                       (slurp filename))))


(defmacro smuggle [module]
  ~(smuggle* ,(string module ".janet")))


(defmacro foreach [binding & body]
  ~(when ,(last binding)
     (map (fn [val]
            (let [,(first binding) val]
              ,;body))
          ,(last binding))))


(defn render-file [filename output]
  (when-let [out (string/replace ".janet" ".html" filename)
             form (try
                    (smuggle* filename)
                    ([err]
                     (print "Skipping file: " filename)))
             output-filename (if output
                               (string output "/" out)
                               (string out))]

     (when (indexed? form)
       (->> form encode (spit output-filename))
       true)))


(defn render [output]
  (var counter 0)
  (var total 0)

  (when output
    (os/mkdir output))

  (let [files (filter janet? (os/dir "."))]
    (each f files
      (++ total)
      (when-let [result (render-file f output)]
        (++ counter))))

  (printf "%d/%d html files generated" counter total))

