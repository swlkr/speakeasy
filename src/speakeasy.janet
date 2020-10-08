(import ./speakeasy/html :as html)


(defn main [& args]
  (let [contents (-> args first slurp)]
    (html/encode ;contents)))

