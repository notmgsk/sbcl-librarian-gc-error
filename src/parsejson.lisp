(in-package #:parsejson)

(sbcl-librarian:define-handle-type json "parsejson_json")

(sbcl-librarian:define-enum-type error-type "parsejson_error_t"
  ("PARSEJSON_ERROR_SUCCESS" 0)
  ("PARSEJSON_ERROR_FAIL" 1))

(sbcl-librarian:define-error-map error-map error-type 0
  ((t (lambda (condition)
        (setf *last-error* (format nil "~a" condition))
        (return-from error-map 1)))))

(defvar *last-error* "")

(defun last-error ()
  (setf sb-kernel::*maximum-error-depth* 1000)
  (format t "ERROR ~a~%" *last-error*)
  (force-output)
  (let ((last-error *last-error*))
    (setf *last-error* "") 
    last-error))

(defun parse (json)
  ;; NOTE: remove this GC and all works fine (at least until GC
  ;; is triggered elsewhere)
  (sb-ext:gc)
  (format t "~a~%" (yason:parse json)))

(sbcl-librarian:define-api parsejson-api (:error-map error-map
                                          :function-prefix "parsejson_")
  (:type json)
  (:type error-type)
  (:function
   (("error" last-error) :string ())
   (("parse" parse) json ((json :string)))))
