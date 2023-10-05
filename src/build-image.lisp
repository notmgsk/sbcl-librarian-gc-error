(require '#:asdf)

(asdf:load-system '#:sbcl-librarian)
(asdf:load-system '#:parsejson)

(in-package #:parsejson)

(sbcl-librarian:define-aggregate-library parsejson (:function-linkage "PARSEJSON_API")
  parsejson-api
  sbcl-librarian:handles)

(sbcl-librarian:build-bindings parsejson "." :initialize-lisp-args `("--dynamic-space-size" ,(format nil "~a" (expt 2 13))))
(sbcl-librarian:build-core-and-die parsejson ".")
