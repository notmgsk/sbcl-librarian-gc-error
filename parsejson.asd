;;;; parsejson.asd

(asdf:defsystem #:parsejson
  :description "Example of a SBCL-LIBRARIAN failure"
  :author "Mark Skilbeck <mark.skilbeck@rigetti.com>"
  :pathname "src/"
  :depends-on (
               ;; NOTE: remove the quilc dependency, and all works fine.
               #:quilc
               #:sbcl-librarian
               #:qvm-app
               )
  :serial t
  :components ((:file "package")
               (:file "parsejson")
               ))
