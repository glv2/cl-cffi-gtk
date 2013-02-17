;;; ----------------------------------------------------------------------------
;;; atdoc-gobject.base.lisp
;;;
;;; Documentation strings for the library GObject.
;;;
;;; The documentation of this file has been copied from the
;;; GObject Reference Manual Version 2.32.4. See http://www.gtk.org
;;;
;;; Copyright (C) 2012 Dieter Kaiser
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU Lesser General Public License for Lisp
;;; as published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version and with a preamble to
;;; the GNU Lesser General Public License that clarifies the terms for use
;;; with Lisp programs and is referred as the LLGPL.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program and the preamble to the Gnu Lesser
;;; General Public License.  If not, see <http://www.gnu.org/licenses/>
;;; and <http://opensource.franz.com/preamble.html>.
;;; ----------------------------------------------------------------------------

(in-package :gobject)

;;; --- g-object ---------------------------------------------------------------

;;; --- g-object-class ---------------------------------------------------------

;;; --- g-object-construct-param -----------------------------------------------

;;; --- g-type-is-object -------------------------------------------------------

;;; --- g-object-type ----------------------------------------------------------

(setf (documentation 'g-object-type 'function)
 "@version{2012-12-29}
  @argument[object]{Object to return the type id for.}
  @return{Type id of object.}
  @short{Get the type id of an object.}
  @begin[Example]{dictionary}
    @begin{pre}
 (g-object-type (make-instance 'gtk-label))
=> #S(GTYPE :NAME \"GtkLabel\" :%ID 134905144)
    @end{pre}
  @end{dictionary}")

;;; --- g-object-type-name -----------------------------------------------------

(setf (documentation 'g-object-type-name 'function)
 "@version{2012-12-29}
  @argument[object]{Object to return the type name for.}
  @return{Type name of object. The string is owned by the type system and should
    not be freed.}
  @short{Get the name of an object's type.}
  @begin[Example]{dictionary}
    @begin{pre}
 (g-object-type-name (make-instance 'gtk-label))
=> \"GtkLabel\"
    @end{pre}
  @end{dictionary}")

;;; --- g-object-class-type ----------------------------------------------------

(setf (documentation 'g-object-class-type 'function)
 "@version{2012-12-29}
  @argument[class]{a valid GObjectClass}
  @return{Type id of class.}
  @short{Get the type id of a class structure.}
  @begin[Example]{dictionary}
    @begin{pre}
 (g-object-class-type (g-type-class-ref (gtype \"GtkLabel\")))
=> #S(GTYPE :NAME \"GtkLabel\" :%ID 134905144)
    @end{pre}
  @end{dictionary}")

;;; --- g-object-class-name ----------------------------------------------------

(setf (documentation 'g-object-class-name 'function)
 "@version{2012-12-29}
  @argument[class]{a valid GObjectClass}
  @return{Type name of class. The string is owned by the type system and should
    not be freed.}
  @short{Return the name of a class structure's type.}
  @begin[Example]{dictionary}
    @begin{pre}
 (g-object-class-name (g-type-class-ref (gtype \"GtkLabel\")))
=> \"GtkLabel\"
    @end{pre}
  @end{dictionary}")

;;; --- g-object-class-install-property ----------------------------------------

(setf (documentation 'g-object-class-install-property 'function)
 "@version{2013-01-01}
  @argument[oclass]{a GObjectClass}
  @argument[property-id]{the id for the new property}
  @argument[pspec]{the GParamSpec for the new property}
  @begin{short}
    Installs a new property. This is usually done in the class initializer.
  @end{short}

  Note that it is possible to redefine a property in a derived class, by
  installing a property with the same name. This can be useful at times, e.g.
  to change the range of allowed values or the default value.")

;;; ----------------------------------------------------------------------------
;;; g_object_class_install_properties ()
;;;
;;; void g_object_class_install_properties (GObjectClass *oclass,
;;;                                         guint n_pspecs,
;;;                                         GParamSpec **pspecs);
;;;
;;; Installs new properties from an array of GParamSpecs. This is usually done
;;; in the class initializer.
;;;
;;; The property id of each property is the index of each GParamSpec in the
;;; pspecs array.
;;;
;;; The property id of 0 is treated specially by GObject and it should not be
;;; used to store a GParamSpec.
;;;
;;; This function should be used if you plan to use a static array of
;;; GParamSpecs and g_object_notify_by_pspec(). For instance, this class
;;; initialization:
;;;
;;;   enum {
;;;     PROP_0, PROP_FOO, PROP_BAR, N_PROPERTIES
;;;   };
;;;
;;;   static GParamSpec *obj_properties[N_PROPERTIES] = { NULL, };
;;;
;;;   static void
;;;   my_object_class_init (MyObjectClass *klass)
;;;   {
;;;     GObjectClass *gobject_class = G_OBJECT_CLASS (klass);
;;;
;;;     obj_properties[PROP_FOO] =
;;;       g_param_spec_int ("foo", "Foo", "Foo",
;;;                         -1, G_MAXINT,
;;;                         0,
;;;                         G_PARAM_READWRITE);
;;;
;;;     obj_properties[PROP_BAR] =
;;;       g_param_spec_string ("bar", "Bar", "Bar",
;;;                            NULL,
;;;                            G_PARAM_READWRITE);
;;;
;;;     gobject_class->set_property = my_object_set_property;
;;;     gobject_class->get_property = my_object_get_property;
;;;     g_object_class_install_properties (gobject_class,
;;;                                        N_PROPERTIES,
;;;                                        obj_properties);
;;;   }
;;;
;;; allows calling g_object_notify_by_pspec() to notify of property changes:
;;;
;;;   void
;;;   my_object_set_foo (MyObject *self, gint foo)
;;;   {
;;;     if (self->foo != foo)
;;;       {
;;;         self->foo = foo;
;;;         g_object_notify_by_pspec (G_OBJECT (self),
;;;                                   obj_properties[PROP_FOO]);
;;;       }
;;;    }
;;;
;;; oclass :
;;;     a GObjectClass
;;;
;;; n_pspecs :
;;;     the length of the GParamSpecs array
;;;
;;; pspecs :
;;;     the GParamSpecs array defining the new properties
;;;
;;; Since 2.26
;;; ----------------------------------------------------------------------------

;;; --- g-object-class-find-property -------------------------------------------

(setf (documentation 'g-object-class-find-property 'function)
 "@version{2013-01-01}
  @argument[oclass]{a GObjectClass}
  @argument[property-name]{the name of the property to look up}
  @return{the GParamSpec for the property, or @code{nil} if the class doesn't
    have a property of that name}
  @short{Looks up the @symbol{g-param-spec} for a property of a class.}
  @begin[Example]{dictionary}
    The @sym{g-param-spec} structure for the property \"label\" of the
    @class{gtk-button} is looked up.
    @begin{pre}
 (setq param
       (g-object-class-find-property (g-type-class-ref (gtype \"GtkButton\"))
                                     \"label\"))
=> #.(SB-SYS:INT-SAP #X08188AE0)
 (foreign-slot-value param '(:struct g-param-spec) :type-instance)
=> #.(SB-SYS:INT-SAP #X08188AE0)
 (foreign-slot-value param '(:struct g-param-spec) :name)
=> \"label\"
 (foreign-slot-value param '(:struct g-param-spec) :flags)
=> (:READABLE :WRITABLE :CONSTRUCT :STATIC-NAME :STATIC-NICK :STATIC-BLURB)
 (foreign-slot-value param '(:struct g-param-spec) :value-type)
=> #S(GTYPE :NAME \"gchararray\" :%ID 64)
 (foreign-slot-value param '(:struct g-param-spec) :owner-type)
=> #S(GTYPE :NAME \"GtkButton\" :%ID 134906760)
    @end{pre}
  @end{dictionary}")

;;; --- g-object-class-list-properties -----------------------------------------

(setf (documentation 'g-object-class-list-properties 'function)
 "@version{2013-1-10}
  @argument[type]{a type id of a class}
  @return{A list of @symbol{g-param-spec} CStruct for all properties of a
    class.}
  @begin{short}
    Get a list of @symbol{g-param-spec} CStruct for all properties of a
    class.
  @end{short}
  @begin[Note]{dictionary}
    The C implementation of the corresponding function does not take a
    type id, but a GObjectClass as the first argument. The Lisp function gets
    the GObjectClass with @code{(g-type-class-ref @arg{type})}.
  @end{dictionary}")

;;; --- g-object-class-override-property ---------------------------------------

(setf (documentation 'g-object-class-override-property 'function)
 "@version{2013-1-10}
  @argument[oclass]{a @symbol{g-object-class} CStruct}
  @argument[property-id]{the new property ID}
  @argument[name]{the name of a property registered in a parent class or in an
    interface of this class.}
  @begin{short}
    Registers @arg{property-id} as referring to a property with the name
    @arg{name} in a parent class or in an interface implemented by @arg{oclass}.
  @end{short}
  This allows this class to override a property implementation in a parent class
  or to provide the implementation of a property from an interface.
  @begin[Note]{dictionary}
    Internally, overriding is implemented by creating a property of type
    @code{GParamSpecOverride}; generally operations that query the properties of
    the object class, such as @fun{g-object-class-find-property} or
    @fun{g-object-class-list-properties} will return the overridden property.
    However, in one case, the @code{construct_properties} argument of the
    constructor virtual function, the @code{GParamSpecOverride} is passed
    instead, so that the @code{param_id} field of the @symbol{g-param-spec}
    CStruct will be correct. For virtually all uses, this makes no difference.
    If you need to get the overridden property, you can call
    @fun{g-param-spec-get-redirect-target}.
  @end{dictionary}
  Since 2.4")

;;; --- g-object-interface-install-property ------------------------------------

(setf (documentation 'g-object-interface-install-property 'function)
 "@version{2013-1-10}
  @argument[g-iface]{any interface vtable for the interface, or the default
    vtable for theinterface.}
  @argument[pspec]{the @symbol{g-param-spec} CStruct for the new property}
  @begin{short}
    Add a property to an interface; this is only useful for interfaces that are
    added to GObject-derived types.
  @end{short}
  Adding a property to an interface forces all objects classes with that
  interface to have a compatible property. The compatible property could be a
  newly created @symbol{g-param-spec} CStruct, but normally
  @fun{g-object-class-override-property} will be used so that the object class
  only needs to provide an implementation and inherits the property
  description, default value, bounds, and so forth from the interface
  property.

  This function is meant to be called from the interface's default vtable
  initialization function (the class_init member of GTypeInfo.) It must not be
  called after after class_init has been called for any object types
  implementing this interface.

  Since 2.4")

;;; --- g-object-interface-find-property ---------------------------------------

(setf (documentation 'g-object-interface-find-property 'function)
 "@version{2013-1-10}
  @argument[g-iface]{any interface vtable for the interface, or the default
    vtable for the interface}
  @argument[property-name]{name of a property to lookup.}
  @return{The @symbol{g-param-spec} CStruct for the property of the interface
    with the name @arg{property-name}, or @code{nil} if no such property
    exists.}
  @begin{short}
    Find the @symbol{g-param-spec} CStruct with the given name for an interface.
  @end{short}
  Generally, the interface vtable passed in as @arg{g-iface} will be the default
  vtable from @fun{g-type-default-interface-ref}, or, if you know the interface
  has already been loaded, @fun{g-type-default-interface-peek}.

  Since 2.4")

;;; --- g-object-interface-list-properties -------------------------------------

(setf (documentation 'g-object-interface-list-properties 'function)
 "@version{2013-1-10}
  @argument[type]{a type id of an interface}
  @return{A list of @symbol{g-param-spec} CStruct for all properties of an
    interface.}
  @begin{short}
    Lists the properties of an interface.
  @end{short}
  Generally, the interface vtable passed in as @arg{g-iface} will be the default
  vtable from @fun{g-type-default-interface-ref}, or, if you know the interface
  has already been loaded, @fun{g-type-default-interface-peek}.
  @begin[Note]{dictionary}
    The C implementation of the corresponding function does not take a
    type id, but a vtable as the first argument. The Lisp function gets
    the vtable with @code{(g-type-default-interface-ref type)}.
  @end{dictionary}
  Since 2.4")

;;; ----------------------------------------------------------------------------
;;; g_object_new ()
;;;
;;; gpointer g_object_new (GType object_type,
;;;                        const gchar *first_property_name,
;;;                        ...);
;;;
;;; Creates a new instance of a GObject subtype and sets its properties.
;;;
;;; Construction parameters (see G_PARAM_CONSTRUCT, G_PARAM_CONSTRUCT_ONLY)
;;; which are not explicitly specified are set to their default values.
;;;
;;; object_type :
;;;     the type id of the GObject subtype to instantiate
;;;
;;; first_property_name :
;;;     the name of the first property
;;;
;;; ... :
;;;     the value of the first property, followed optionally by more name/value
;;;     pairs, followed by NULL
;;;
;;; Returns :
;;;     a new instance of object_type
;;; ----------------------------------------------------------------------------


;;; --- g-object-newv ----------------------------------------------------------


;;; --- g-parameter ------------------------------------------------------------


;;; --- g-object-ref -----------------------------------------------------------

(setf (documentation 'g-object-ref 'function)
 "@version{2013-1-10}
  @argument[object]{a @class{g-object} instance}
  @return{the same object}
  @short{Increases the reference count of object.}")

;;; --- g-object-unref ---------------------------------------------------------

(setf (documentation 'g-object-unref 'function)
 "@version{2013-1-10}
  @argument[object]{a @class{g-object} instance}
  @begin{short}
    Decreases the reference count of object.
  @end{short}
  When its reference count drops to 0, the object is finalized (i.e. its memory
  is freed).")

;;; --- g-object-ref-sink ------------------------------------------------------

(setf (documentation 'g-object-ref-sink 'function)
 "@version{2013-1-10}
  @argument[object]{a @class{g-object} instance}
  @return{@arg{object}}
  @begin{short}
    Increase the reference count of @arg{object}, and possibly remove the
    floating reference, if object has a floating reference.
  @end{short}
  In other words, if the object is floating, then this call \"assumes
  ownership\" of the floating reference, converting it to a normal reference by
  clearing the floating flag while leaving the reference count unchanged. If
  the object is not floating, then this call adds a new normal reference
  increasing the reference count by one.

  Since 2.10")

;;; ----------------------------------------------------------------------------
;;; g_clear_object ()
;;;
;;; void g_clear_object (volatile GObject **object_ptr);
;;;
;;; Clears a reference to a GObject.
;;;
;;; object_ptr must not be NULL.
;;;
;;; If the reference is NULL then this function does nothing. Otherwise, the
;;; reference count of the object is decreased and the pointer is set to NULL.
;;;
;;; This function is threadsafe and modifies the pointer atomically, using
;;; memory barriers where needed.
;;;
;;; A macro is also included that allows this function to be used without
;;; pointer casts.
;;;
;;; object_ptr :
;;;     a pointer to a GObject reference
;;;
;;; Since 2.28
;;; ----------------------------------------------------------------------------

;;; --- g-initially-unowned ----------------------------------------------------



;;; ----------------------------------------------------------------------------
;;; GInitiallyUnownedClass
;;;
;;; typedef struct _GObjectClass GInitiallyUnownedClass;
;;;
;;; The class structure for the GInitiallyUnowned type.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; G_TYPE_INITIALLY_UNOWNED
;;;
;;; #define G_TYPE_INITIALLY_UNOWNED (g_initially_unowned_get_type())
;;;
;;; The type for GInitiallyUnowned.
;;; ----------------------------------------------------------------------------

#|
;;; ----------------------------------------------------------------------------
;;; g_object_is_floating ()
;;;
;;; gboolean g_object_is_floating (gpointer object);
;;;
;;; Checks whether object has a floating reference.
;;;
;;; object :
;;;     a GObject
;;;
;;; Returns :
;;;     TRUE if object has a floating reference
;;;
;;; Since 2.10
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_is_floating" g-object-is-floating) :boolean
  (object :pointer))

(export 'g-object-is-floating)

;;; ----------------------------------------------------------------------------
;;; g_object_force_floating ()
;;;
;;; void g_object_force_floating (GObject *object);
;;;
;;; This function is intended for GObject implementations to re-enforce a
;;; floating object reference. Doing this is seldom required: all
;;; GInitiallyUnowneds are created with a floating reference which usually just
;;; needs to be sunken by calling g_object_ref_sink().
;;;
;;; object :
;;;     a GObject
;;;
;;; Since 2.10
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_force_floating" g-object-force-floating) :void
  (object :pointer))

(export 'g-object-force-floating)

;;; ----------------------------------------------------------------------------
;;; GWeakNotify ()
;;;
;;; void (*GWeakNotify) (gpointer data,
;;;                      GObject *where_the_object_was);
;;;
;;; A GWeakNotify function can be added to an object as a callback that gets
;;; triggered when the object is finalized. Since the object is already being
;;; finalized when the GWeakNotify is called, there's not much you could do with
;;; the object, apart from e.g. using its address as hash-index or the like.
;;;
;;; data :
;;;     data that was provided when the weak reference was established
;;;
;;; where_the_object_was :
;;;     the object being finalized
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_weak_ref ()
;;;
;;; void g_object_weak_ref (GObject *object, GWeakNotify notify, gpointer data);
;;;
;;; Adds a weak reference callback to an object. Weak references are used for
;;; notification when an object is finalized. They are called "weak references"
;;; because they allow you to safely hold a pointer to an object without calling
;;; g_object_ref() (g_object_ref() adds a strong reference, that is, forces the
;;; object to stay alive).
;;;
;;; Note that the weak references created by this method are not thread-safe:
;;; they cannot safely be used in one thread if the object's last
;;; g_object_unref() might happen in another thread. Use GWeakRef if
;;; thread-safety is required.
;;;
;;; object :
;;;     GObject to reference weakly
;;;
;;; notify :
;;;     callback to invoke before the object is freed
;;;
;;; data :
;;;     extra data to pass to notify
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_weak_ref" g-object-weak-ref) :void
  (object :pointer)
  (notify :pointer)
  (data :pointer))

(export 'g-object-weak-ref)

;;; ----------------------------------------------------------------------------
;;; g_object_weak_unref ()
;;;
;;; void g_object_weak_unref (GObject *object,
;;;                           GWeakNotify notify,
;;;                           gpointer data);
;;;
;;; Removes a weak reference callback to an object.
;;;
;;; object :
;;;     GObject to remove a weak reference from
;;;
;;; notify :
;;;     callback to search for
;;;
;;; data :
;;;     data to search for
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_weak_unref" g-object-weak-unref) :void
  (object :pointer)
  (notify :pointer)
  (data :pointer))

(export 'g-object-weak-unref)

;;; ----------------------------------------------------------------------------
;;; g_object_add_weak_pointer ()
;;;
;;; void g_object_add_weak_pointer (GObject *object,
;;;                                 gpointer *weak_pointer_location);
;;;
;;; Adds a weak reference from weak_pointer to object to indicate that the
;;; pointer located at weak_pointer_location is only valid during the lifetime
;;; of object. When the object is finalized, weak_pointer will be set to NULL.
;;;
;;; Note that as with g_object_weak_ref(), the weak references created by this
;;; method are not thread-safe: they cannot safely be used in one thread if the
;;; object's last g_object_unref() might happen in another thread. Use GWeakRef
;;; if thread-safety is required.
;;;
;;; object :
;;;     The object that should be weak referenced.
;;;
;;; weak_pointer_location :
;;;     The memory address of a pointer.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_remove_weak_pointer ()
;;;
;;; void g_object_remove_weak_pointer (GObject *object,
;;;                                    gpointer *weak_pointer_location);
;;;
;;; Removes a weak reference from object that was previously added using
;;; g_object_add_weak_pointer(). The weak_pointer_location has to match the one
;;; used with g_object_add_weak_pointer().
;;;
;;; object :
;;;     The object that is weak referenced.
;;;
;;; weak_pointer_location :
;;;     The memory address of a pointer.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GToggleNotify ()
;;;
;;; void (*GToggleNotify) (gpointer data,
;;;                        GObject *object,
;;;                        gboolean is_last_ref);
;;;
;;; A callback function used for notification when the state of a toggle
;;; reference changes. See g_object_add_toggle_ref().
;;;
;;; data :
;;;     Callback data passed to g_object_add_toggle_ref()
;;;
;;; object :
;;;     The object on which g_object_add_toggle_ref() was called.
;;;
;;; is_last_ref :
;;;     TRUE if the toggle reference is now the last reference to the object.
;;;     FALSE if the toggle reference was the last reference and there are now
;;;     other references.
;;; ----------------------------------------------------------------------------

(defcallback g-toggle-notify :void
    ((data :pointer) (object :pointer) (is-last-ref :boolean))
  (declare (ignore data))
  (log-for :gc "~A is now ~A with ~A refs~%"
           object
           (if is-last-ref "weak pointer" "strong pointer")
           (ref-count object))
  (log-for :gc "obj: ~A~%"
           (or (gethash (pointer-address object) *foreign-gobjects-strong*)
               (gethash (pointer-address object) *foreign-gobjects-weak*)))
  (if is-last-ref
      (let* ((obj-adr (pointer-address object))
             (obj (gethash obj-adr *foreign-gobjects-strong*)))
        (if obj
            (progn
              (remhash obj-adr *foreign-gobjects-strong*)
              (setf (gethash obj-adr *foreign-gobjects-weak*) obj))
            (progn
              (log-for :gc "GObject at ~A has no lisp-side (strong) reference"
                        object)
              (warn "GObject at ~A has no lisp-side (strong) reference"
                    object))))
      (let* ((obj-adr (pointer-address object))
             (obj (gethash obj-adr *foreign-gobjects-weak*)))
        (unless obj
          (log-for :gc "GObject at ~A has no lisp-side (weak) reference"
                   object)
          (warn "GObject at ~A has no lisp-side (weak) reference" object))
        (remhash obj-adr *foreign-gobjects-weak*)
        (setf (gethash obj-adr *foreign-gobjects-strong*) obj))))

;;; ----------------------------------------------------------------------------
;;; g_object_add_toggle_ref ()
;;;
;;; void g_object_add_toggle_ref (GObject *object,
;;;                               GToggleNotify notify,
;;;                               gpointer data);
;;;
;;; Increases the reference count of the object by one and sets a callback to be
;;; called when all other references to the object are dropped, or when this is
;;; already the last reference to the object and another reference is
;;; established.
;;;
;;; This functionality is intended for binding object to a proxy object managed
;;; by another memory manager. This is done with two paired references: the
;;; strong reference added by g_object_add_toggle_ref() and a reverse reference
;;; to the proxy object which is either a strong reference or weak reference.
;;;
;;; The setup is that when there are no other references to object, only a weak
;;; reference is held in the reverse direction from object to the proxy object,
;;; but when there are other references held to object, a strong reference is
;;; held. The notify callback is called when the reference from object to the
;;; proxy object should be toggled from strong to weak (is_last_ref true) or
;;; weak to strong (is_last_ref false).
;;;
;;; Since a (normal) reference must be held to the object before calling
;;; g_object_add_toggle_ref(), the initial state of the reverse link is always
;;; strong.
;;;
;;; Multiple toggle references may be added to the same gobject, however if
;;; there are multiple toggle references to an object, none of them will ever be
;;; notified until all but one are removed. For this reason, you should only
;;; ever use a toggle reference if there is important state in the proxy object.
;;;
;;; object :
;;;     a GObject
;;;
;;; notify :
;;;     a function to call when this reference is the last reference to the
;;;     object, or is no longer the last reference.
;;;
;;; data :
;;;     data to pass to notify
;;;
;;; Since 2.8
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_add_toggle_ref" g-object-add-toggle-ref) :void
  (object :pointer)
  (notify :pointer)
  (data :pointer))

(export 'g-object-add-toggle-ref)

;;; ----------------------------------------------------------------------------
;;; g_object_remove_toggle_ref ()
;;;
;;; void g_object_remove_toggle_ref (GObject *object,
;;;                                  GToggleNotify notify,
;;;                                  gpointer data);
;;;
;;; Removes a reference added with g_object_add_toggle_ref(). The reference
;;; count of the object is decreased by one.
;;;
;;; object :
;;;     a GObject
;;;
;;; notify :
;;;     a function to call when this reference is the last reference to the
;;;     object, or is no longer the last reference.
;;;
;;; data :
;;;     data to pass to notify
;;;
;;; Since 2.8
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_remove_toggle_ref" g-object-remove-toggle-ref) :void
  (object :pointer)
  (notify :pointer)
  (data :pointer))

(export 'g-object-remove-toggle-ref)

;;; ----------------------------------------------------------------------------
;;; g_object_connect ()
;;;
;;; gpointer g_object_connect (gpointer object,
;;;                            const gchar *signal_spec,
;;;                            ...);
;;;
;;; A convenience function to connect multiple signals at once.
;;;
;;; The signal specs expected by this function have the form
;;; "modifier::signal_name", where modifier can be one of the following:
;;;
;;; signal
;;;
;;;     equivalent to g_signal_connect_data (..., NULL, 0)
;;;
;;; object_signal, object-signal
;;;
;;;     equivalent to g_signal_connect_object (..., 0)
;;;
;;; swapped_signal, swapped-signal
;;;
;;;     equivalent to g_signal_connect_data (..., NULL, G_CONNECT_SWAPPED)
;;;
;;; swapped_object_signal, swapped-object-signal
;;;
;;;     equivalent to g_signal_connect_object (..., G_CONNECT_SWAPPED)
;;;
;;; signal_after, signal-after
;;;
;;;     equivalent to g_signal_connect_data (..., NULL, G_CONNECT_AFTER)
;;;
;;; object_signal_after, object-signal-after
;;;
;;;     equivalent to g_signal_connect_object (..., G_CONNECT_AFTER)
;;;
;;; swapped_signal_after, swapped-signal-after
;;;
;;;     equivalent to g_signal_connect_data (..., NULL,
;;;                                          G_CONNECT_SWAPPED |
;;;                                          G_CONNECT_AFTER)
;;;
;;; swapped_object_signal_after, swapped-object-signal-after
;;;
;;;   equivalent to g_signal_connect_object (..., G_CONNECT_SWAPPED |
;;;                                               G_CONNECT_AFTER)
;;;
;;;   menu->toplevel = g_object_connect (g_object_new (GTK_TYPE_WINDOW,
;;;                              "type", GTK_WINDOW_POPUP,
;;;                              "child", menu,
;;;                              NULL),
;;;                  "signal::event", gtk_menu_window_event, menu,
;;;                  "signal::size_request", gtk_menu_window_size_request, menu,
;;;                  "signal::destroy", gtk_widget_destroyed, &menu->toplevel,
;;;                  NULL);
;;;
;;; object :
;;;     a GObject
;;;
;;; signal_spec :
;;;     the spec for the first signal
;;;
;;; ... :
;;;     GCallback for the first signal, followed by data for the first signal,
;;;     followed optionally by more signal spec/callback/data triples, followed
;;;     by NULL
;;;
;;; Returns :
;;;     object
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_disconnect ()
;;;
;;; void g_object_disconnect (gpointer object,
;;;                           const gchar *signal_spec,
;;;                           ...);
;;;
;;; A convenience function to disconnect multiple signals at once.
;;;
;;; The signal specs expected by this function have the form "any_signal", which
;;; means to disconnect any signal with matching callback and data, or
;;; "any_signal::signal_name", which only disconnects the signal named
;;; "signal_name".
;;;
;;; object :
;;;     a GObject
;;;
;;; signal_spec :
;;;     the spec for the first signal
;;;
;;; ... :
;;;     GCallback for the first signal, followed by data for the first signal,
;;;     followed optionally by more signal spec/callback/data triples, followed
;;;     by NULL
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_set ()
;;;
;;; void g_object_set (gpointer object, const gchar *first_property_name, ...);
;;;
;;; Sets properties on an object.
;;;
;;; object :
;;;     a GObject
;;;
;;; first_property_name :
;;;     name of the first property to set
;;;
;;; ... :
;;;     value for the first property, followed optionally by more name/value
;;;     pairs, followed by NULL
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_get ()
;;;
;;; void g_object_get (gpointer object, const gchar *first_property_name, ...);
;;;
;;; Gets properties of an object.
;;;
;;; In general, a copy is made of the property contents and the caller is
;;; responsible for freeing the memory in the appropriate manner for the type,
;;; for instance by calling g_free() or g_object_unref().
;;;
;;; Example 2. Using g_object_get()
;;;
;;; An example of using g_object_get() to get the contents of three properties -
;;; one of type G_TYPE_INT, one of type G_TYPE_STRING, and one of type
;;; G_TYPE_OBJECT:
;;;
;;;   gint intval;
;;;   gchar *strval;
;;;   GObject *objval;
;;;
;;;   g_object_get (my_object,
;;;                 "int-property", &intval,
;;;                 "str-property", &strval,
;;;                 "obj-property", &objval,
;;;                 NULL);
;;;
;;;   // Do something with intval, strval, objval
;;;
;;;   g_free (strval);
;;;   g_object_unref (objval);
;;;
;;; object :
;;;     a GObject
;;;
;;; first_property_name :
;;;     name of the first property to get
;;;
;;; ... :
;;;     return location for the first property, followed optionally by more
;;;     name/return location pairs, followed by NULL
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_notify ()
;;;
;;; void g_object_notify (GObject *object, const gchar *property_name);
;;;
;;; Emits a "notify" signal for the property property_name on object.
;;;
;;; When possible, eg. when signaling a property change from within the class
;;; that registered the property, you should use g_object_notify_by_pspec()
;;; instead.
;;;
;;; object :
;;;     a GObject
;;;
;;; property_name :
;;;     the name of a property installed on the class of object.
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_notify" g-object-notify) :void
  (object :pointer)
  (property-name :string))

(export 'g-object-notify)

;;; ----------------------------------------------------------------------------
;;; g_object_notify_by_pspec ()
;;;
;;; void g_object_notify_by_pspec (GObject *object, GParamSpec *pspec);
;;;
;;; Emits a "notify" signal for the property specified by pspec on object.
;;;
;;; This function omits the property name lookup, hence it is faster than
;;; g_object_notify().
;;;
;;; One way to avoid using g_object_notify() from within the class that
;;; registered the properties, and using g_object_notify_by_pspec() instead, is
;;; to store the GParamSpec used with g_object_class_install_property() inside a
;;; static array, e.g.:
;;;
;;;   enum
;;;   {
;;;     PROP_0,
;;;     PROP_FOO,
;;;     PROP_LAST
;;;   };
;;;
;;;   static GParamSpec *properties[PROP_LAST];
;;;
;;;   static void
;;;   my_object_class_init (MyObjectClass *klass)
;;;   {
;;;     properties[PROP_FOO] = g_param_spec_int ("foo", "Foo", "The foo",
;;;                                              0, 100,
;;;                                              50,
;;;                                              G_PARAM_READWRITE);
;;;     g_object_class_install_property (gobject_class,
;;;                                      PROP_FOO,
;;;                                      properties[PROP_FOO]);
;;;   }
;;;
;;; and then notify a change on the "foo" property with:
;;;
;;;   g_object_notify_by_pspec (self, properties[PROP_FOO]);
;;;
;;; object :
;;;     a GObject
;;;
;;; pspec :
;;;     the GParamSpec of a property installed on the class of object.
;;;
;;; Since 2.26
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_freeze_notify ()
;;;
;;; void g_object_freeze_notify (GObject *object);
;;;
;;; Increases the freeze count on object. If the freeze count is non-zero, the
;;; emission of "notify" signals on object is stopped. The signals are queued
;;; until the freeze count is decreased to zero.
;;;
;;; This is necessary for accessors that modify multiple properties to prevent
;;; premature notification while the object is still being modified.
;;;
;;; object :
;;;     a GObject
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_freeze_notify" g-object-freeze-notify) :void
  (object :pointer))

(export 'g-object-freeze-notify)

;;; ----------------------------------------------------------------------------
;;; g_object_thaw_notify ()
;;;
;;; void g_object_thaw_notify (GObject *object);
;;;
;;; Reverts the effect of a previous call to g_object_freeze_notify(). The
;;; freeze count is decreased on object and when it reaches zero, all queued
;;; "notify" signals are emitted.
;;;
;;; It is an error to call this function when the freeze count is zero.
;;;
;;; object :
;;;     a GObject
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_thaw_notify" g-object-thaw-notify) :void
  (object :pointer))

(export 'g-object-thaw-notify)

;;; ----------------------------------------------------------------------------
;;; g_object_get_data ()
;;;
;;; gpointer g_object_get_data (GObject *object, const gchar *key);
;;;
;;; Gets a named field from the objects table of associations (see
;;; g_object_set_data()).
;;;
;;; object :
;;;     GObject containing the associations
;;;
;;; key :
;;;     name of the key for that association
;;;
;;; Returns :
;;;     the data if found, or NULL if no such data exists
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_get_data" g-object-get-data) :pointer
  (object g-object)
  (key :string))

(export 'g-object-get-data)

;;; ----------------------------------------------------------------------------
;;; g_object_set_data ()
;;;
;;; void g_object_set_data (GObject *object, const gchar *key, gpointer data);
;;;
;;; Each object carries around a table of associations from strings to pointers.
;;; This function lets you set an association.
;;;
;;; If the object already had an association with that name, the old association
;;; will be destroyed.
;;;
;;; object :
;;;     GObject containing the associations.
;;;
;;; key :
;;;     name of the key
;;;
;;; data :
;;;     data to associate with that key
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_set_data" g-object-set-data) :void
  (object g-object)
  (key :string)
  (new-value :pointer))

(export 'g-object-set-data)

;;; ----------------------------------------------------------------------------
;;; g_object_set_data_full ()
;;;
;;; void g_object_set_data_full (GObject *object,
;;;                              const gchar *key,
;;;                              gpointer data,
;;;                              GDestroyNotify destroy);
;;;
;;; Like g_object_set_data() except it adds notification for when the
;;; association is destroyed, either by setting it to a different value or when
;;; the object is destroyed.
;;;
;;; Note that the destroy callback is not called if data is NULL.
;;;
;;; object :
;;;     GObject containing the associations
;;;
;;; key :
;;;     name of the key
;;;
;;; data :
;;;     data to associate with that key
;;;
;;; destroy :
;;;     function to call when the association is destroyed
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_set_data_full" g-object-set-data-full) :void
  (object :pointer)
  (key :string)
  (data :pointer)
  (destory :pointer))

(export 'g-object-set-data-full)

;;; ----------------------------------------------------------------------------
;;; g_object_steal_data ()
;;;
;;; gpointer g_object_steal_data (GObject *object, const gchar *key);
;;;
;;; Remove a specified datum from the object's data associations, without
;;; invoking the association's destroy handler.
;;;
;;; object :
;;;     GObject containing the associations
;;;
;;; key :
;;;     name of the key
;;;
;;; Returns :
;;;     the data if found, or NULL if no such data exists
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_steal_data" g-object-steal-data) :pointer
  (object :pointer)
  (key :string))

(export 'g-object-steal-data)

;;; ----------------------------------------------------------------------------
;;; g_object_get_qdata ()
;;;
;;; gpointer g_object_get_qdata (GObject *object, GQuark quark);
;;;
;;; This function gets back user data pointers stored via g_object_set_qdata().
;;;
;;; object :
;;;     The GObject to get a stored user data pointer from
;;;
;;; quark :
;;;     A GQuark, naming the user data pointer
;;;
;;; Returns :
;;;     The user data pointer set, or NULL.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_set_qdata ()
;;;
;;; void g_object_set_qdata (GObject *object, GQuark quark, gpointer data);
;;;
;;; This sets an opaque, named pointer on an object. The name is specified
;;; through a GQuark (retrived e.g. via g_quark_from_static_string()), and the
;;; pointer can be gotten back from the object with g_object_get_qdata() until
;;; the object is finalized. Setting a previously set user data pointer,
;;; overrides (frees) the old pointer set, using NULL as pointer essentially
;;; removes the data stored.
;;;
;;; object :
;;;     The GObject to set store a user data pointer
;;;
;;; quark :
;;;     A GQuark, naming the user data pointer
;;;
;;; data :
;;;     An opaque user data pointer
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_set_qdata_full ()
;;;
;;; void g_object_set_qdata_full (GObject *object,
;;;                               GQuark quark,
;;;                               gpointer data,
;;;                               GDestroyNotify destroy);
;;;
;;; This function works like g_object_set_qdata(), but in addition, a
;;; void (*destroy) (gpointer) function may be specified which is called with
;;; data as argument when the object is finalized, or the data is being
;;; overwritten by a call to g_object_set_qdata() with the same quark.
;;;
;;; object :
;;;     The GObject to set store a user data pointer
;;;
;;; quark :
;;;     A GQuark, naming the user data pointer
;;;
;;; data :
;;;     An opaque user data pointer
;;;
;;; destroy :
;;;     Function to invoke with data as argument, when data needs to be freed
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_steal_qdata ()
;;;
;;; gpointer g_object_steal_qdata (GObject *object, GQuark quark);
;;;
;;; This function gets back user data pointers stored via g_object_set_qdata()
;;; and removes the data from object without invoking its destroy() function (if
;;; any was set). Usually, calling this function is only required to update user
;;; data pointers with a destroy notifier, for example:
;;;
;;;   void
;;;   object_add_to_user_list (GObject     *object,
;;;                            const gchar *new_string)
;;;   {
;;;     // the quark, naming the object data
;;;     GQuark quark_string_list = g_quark_from_static_string("my-string-list");
;;;     // retrive the old string list
;;;     GList *list = g_object_steal_qdata (object, quark_string_list);
;;;
;;;     // prepend new string
;;;     list = g_list_prepend (list, g_strdup (new_string));
;;;     // this changed 'list', so we need to set it again
;;;     g_object_set_qdata_full (object, quark_string_list, list,
;;;                              free_string_list);
;;;   }
;;;   static void
;;;   free_string_list (gpointer data)
;;;   {
;;;     GList *node, *list = data;
;;;
;;;     for (node = list; node; node = node->next)
;;;       g_free (node->data);
;;;     g_list_free (list);
;;;   }
;;;
;;; Using g_object_get_qdata() in the above example, instead of
;;; g_object_steal_qdata() would have left the destroy function set, and thus
;;; the partial string list would have been freed upon
;;; g_object_set_qdata_full().
;;;
;;; object :
;;;     The GObject to get a stored user data pointer from
;;;
;;; quark :
;;;     A GQuark, naming the user data pointer
;;;
;;; Returns :
;;;     The user data pointer set, or NULL.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_set_property ()
;;;
;;; void g_object_set_property (GObject *object,
;;;                             const gchar *property_name,
;;;                             const GValue *value);
;;;
;;; Sets a property on an object.
;;;
;;; object :
;;;     a GObject
;;;
;;; property_name :
;;;     the name of the property to set
;;;
;;; value :
;;;     the value
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_set_property" %g-object-set-property) :void
  (object :pointer)
  (property-name :string)
  (value (:pointer g-value)))

(defun set-gobject-property (object-ptr property-name new-value
                                        &optional property-type)
  (unless property-type
    (setf property-type
          (class-property-type (g-type-from-instance object-ptr)
                               property-name
                               :assert-writable t)))
  (with-foreign-object (value 'g-value)
    (set-g-value value new-value property-type :zero-g-value t)
    (unwind-protect
      (%g-object-set-property object-ptr property-name value)
      (g-value-unset value))))

;;; ----------------------------------------------------------------------------
;;; g_object_get_property ()
;;;
;;; void g_object_get_property (GObject *object,
;;;                             const gchar *property_name,
;;;                             GValue *value);
;;;
;;; Gets a property of an object. value must have been initialized to the
;;; expected type of the property (or a type to which the expected type can be
;;; transformed) using g_value_init().
;;;
;;; In general, a copy is made of the property contents and the caller is
;;; responsible for freeing the memory by calling g_value_unset().
;;;
;;; Note that g_object_get_property() is really intended for language bindings,
;;; g_object_get() is much more convenient for C programming.
;;;
;;; object :
;;;     a GObject
;;;
;;; property_name :
;;;     the name of the property to get
;;;
;;; value :
;;;     return location for the property value
;;; ----------------------------------------------------------------------------

(defcfun ("g_object_get_property" %g-object-get-property) :void
  (object :pointer)
  (property-name :string)
  (value (:pointer g-value)))

(defun get-gobject-property (object-ptr property-name &optional property-type)
  (restart-case
    (unless property-type
      (setf property-type
            (class-property-type (g-type-from-instance object-ptr)
                                 property-name
                                 :assert-readable t)))
    (return-nil () (return-from get-gobject-property nil)))
  (with-foreign-object (value 'g-value)
    (g-value-zero value)
    (g-value-init value property-type)
    (%g-object-get-property object-ptr property-name value)
    (unwind-protect
      (parse-g-value value)
      (g-value-unset value))))

;;; ----------------------------------------------------------------------------
;;; g_object_new_valist ()
;;;
;;; GObject * g_object_new_valist (GType object_type,
;;;                                const gchar *first_property_name,
;;;                                va_list var_args);
;;;
;;; Creates a new instance of a GObject subtype and sets its properties.
;;;
;;; Construction parameters (see G_PARAM_CONSTRUCT, G_PARAM_CONSTRUCT_ONLY)
;;; which are not explicitly specified are set to their default values.
;;;
;;; object_type :
;;;     the type id of the GObject subtype to instantiate
;;;
;;; first_property_name :
;;;     the name of the first property
;;;
;;; var_args :
;;;     the value of the first property, followed optionally by more name/value
;;;     pairs, followed by NULL
;;;
;;; Returns :
;;;     a new instance of object_type
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_set_valist ()
;;;
;;; void g_object_set_valist (GObject *object,
;;;                           const gchar *first_property_name,
;;;                           va_list var_args);
;;;
;;; Sets properties on an object.
;;;
;;; object :
;;;     a GObject
;;;
;;; first_property_name :
;;;     name of the first property to set
;;;
;;; var_args :
;;;     value for the first property, followed optionally by more name/value
;;;     pairs, followed by NULL
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_get_valist ()
;;;
;;; void g_object_get_valist (GObject *object,
;;;                           const gchar *first_property_name,
;;;                           va_list var_args);
;;;
;;; Gets properties of an object.
;;;
;;; In general, a copy is made of the property contents and the caller is
;;; responsible for freeing the memory in the appropriate manner for the type,
;;; for instance by calling g_free() or g_object_unref().
;;;
;;; See g_object_get().
;;;
;;; object :
;;;     a GObject
;;;
;;; first_property_name :
;;;     name of the first property to get
;;;
;;; var_args :
;;;     return location for the first property, followed optionally by more
;;;     name/return location pairs, followed by NULL
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_watch_closure ()
;;;
;;; void g_object_watch_closure (GObject *object, GClosure *closure);
;;;
;;; This function essentially limits the life time of the closure to the life
;;; time of the object. That is, when the object is finalized, the closure is
;;; invalidated by calling g_closure_invalidate() on it, in order to prevent
;;; invocations of the closure with a finalized (nonexisting) object. Also,
;;; g_object_ref() and g_object_unref() are added as marshal guards to the
;;; closure, to ensure that an extra reference count is held on object during
;;; invocation of the closure. Usually, this function will be called on closures
;;; that use this object as closure data.
;;;
;;; object :
;;;     GObject restricting lifetime of closure
;;;
;;; closure :
;;;     GClosure to watch
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_object_run_dispose ()
;;;
;;; void g_object_run_dispose (GObject *object);
;;;
;;; Releases all references to other objects. This can be used to break
;;; reference cycles.
;;;
;;; This functions should only be called from object system implementations.
;;;
;;; object :
;;;     a GObject
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; G_OBJECT_WARN_INVALID_PROPERTY_ID()
;;;
;;; #define G_OBJECT_WARN_INVALID_PROPERTY_ID(object, property_id, pspec)
;;;
;;; This macro should be used to emit a standard warning about unexpected
;;; properties in set_property() and get_property() implementations.
;;;
;;; object :
;;;     the GObject on which set_property() or get_property() was called
;;;
;;; property_id :
;;;     the numeric id of the property
;;;
;;; pspec :
;;;     the GParamSpec of the property
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GWeakRef
;;;
;;; typedef struct {
;;; } GWeakRef;
;;;
;;; A structure containing a weak reference to a GObject. It can either be empty
;;; (i.e. point to NULL), or point to an object for as long as at least one
;;; "strong" reference to that object exists. Before the object's
;;; GObjectClass.dispose method is called, every GWeakRef associated with
;;; becomes empty (i.e. points to NULL).
;;;
;;; Like GValue, GWeakRef can be statically allocated, stack- or heap-allocated,
;;; or embedded in larger structures.
;;;
;;; Unlike g_object_weak_ref() and g_object_add_weak_pointer(), this weak
;;; reference is thread-safe: converting a weak pointer to a reference is atomic
;;; with respect to invalidation of weak pointers to destroyed objects.
;;;
;;; If the object's GObjectClass.dispose method results in additional references
;;; to the object being held, any GWeakRefs taken before it was disposed will
;;; continue to point to NULL. If GWeakRefs are taken after the object is
;;; disposed and re-referenced, they will continue to point to it until its
;;; refcount goes back to zero, at which point they too will be invalidated.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_weak_ref_init ()
;;;
;;; void g_weak_ref_init (GWeakRef *weak_ref, gpointer object);
;;;
;;; Initialise a non-statically-allocated GWeakRef.
;;;
;;; This function also calls g_weak_ref_set() with object on the
;;; freshly-initialised weak reference.
;;;
;;; This function should always be matched with a call to g_weak_ref_clear(). It
;;; is not necessary to use this function for a GWeakRef in static storage
;;; because it will already be properly initialised. Just use g_weak_ref_set()
;;; directly.
;;;
;;; weak_ref :
;;;     uninitialized or empty location for a weak reference
;;;
;;; object :
;;;     a GObject or NULL
;;;
;;; Since 2.32
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_weak_ref_clear ()
;;;
;;; void g_weak_ref_clear (GWeakRef *weak_ref);
;;;
;;; Frees resources associated with a non-statically-allocated GWeakRef. After
;;; this call, the GWeakRef is left in an undefined state.
;;;
;;; You should only call this on a GWeakRef that previously had
;;; g_weak_ref_init() called on it.
;;;
;;; weak_ref :
;;;     location of a weak reference, which may be empty
;;;
;;; Since 2.32
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_weak_ref_get ()
;;;
;;; gpointer g_weak_ref_get (GWeakRef *weak_ref);
;;;
;;; If weak_ref is not empty, atomically acquire a strong reference to the
;;; object it points to, and return that reference.
;;;
;;; This function is needed because of the potential race between taking the
;;; pointer value and g_object_ref() on it, if the object was losing its last
;;; reference at the same time in a different thread.
;;;
;;; The caller should release the resulting reference in the usual way, by using
;;; g_object_unref().
;;;
;;; weak_ref :
;;;     location of a weak reference to a GObject
;;;
;;; Returns :
;;;     the object pointed to by weak_ref, or NULL if it was empty
;;;
;;; Since 2.32
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; g_weak_ref_set ()
;;;
;;; void g_weak_ref_set (GWeakRef *weak_ref, gpointer object);
;;;
;;; Change the object to which weak_ref points, or set it to NULL.
;;;
;;; You must own a strong reference on object while calling this function.
;;;
;;; weak_ref :
;;;     location for a weak reference
;;;
;;; object :
;;;     a GObject or NULL
;;;
;;; Since 2.32
;;; ----------------------------------------------------------------------------
|#

;;; --- End of file atdoc-gobject.base.lisp ------------------------------------