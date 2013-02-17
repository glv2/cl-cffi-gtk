;;; ----------------------------------------------------------------------------
;;; gtk.cell-area-context.lisp
;;;
;;; The documentation has been copied from the GTK+ 3 Reference Manual
;;; Version 3.4.3. See http://www.gtk.org.
;;;
;;; Copyright (C) 2012, 2013 Dieter Kaiser
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
;;;
;;; GtkCellAreaContext
;;;
;;; Stores geometrical information for a series of rows in a GtkCellArea
;;;
;;; Synopsis
;;;
;;;     GtkCellAreaContextClass
;;;     GtkCellAreaContext
;;;
;;;     gtk_cell_area_context_get_area
;;;     gtk_cell_area_context_allocate
;;;     gtk_cell_area_context_reset
;;;     gtk_cell_area_context_get_preferred_width
;;;     gtk_cell_area_context_get_preferred_height
;;;     gtk_cell_area_context_get_preferred_height_for_width
;;;     gtk_cell_area_context_get_preferred_width_for_height
;;;     gtk_cell_area_context_get_allocation
;;;     gtk_cell_area_context_push_preferred_width
;;;     gtk_cell_area_context_push_preferred_height
;;;
;;; Object Hierarchy
;;;
;;;   GObject
;;;    +----GtkCellAreaContext
;;;
;;; Properties
;;;
;;;   "area"                     GtkCellArea*         : Read / Write / Construct
;;;   "minimum-height"           gint                 : Read
;;;   "minimum-width"            gint                 : Read
;;;   "natural-height"           gint                 : Read
;;;   "natural-width"            gint                 : Read
;;;
;;; Description
;;;
;;; The GtkCellAreaContext object is created by a given GtkCellArea
;;; implementation via its GtkCellAreaClass.create_context() virtual method and
;;; is used to store cell sizes and alignments for a series of GtkTreeModel rows
;;; that are requested and rendered in the same context.
;;;
;;; GtkCellLayout widgets can create any number of contexts in which to request
;;; and render groups of data rows. However its important that the same context
;;; which was used to request sizes for a given GtkTreeModel row also be used
;;; for the same row when calling other GtkCellArea APIs such as
;;; gtk_cell_area_render() and gtk_cell_area_event().
;;;
;;; ----------------------------------------------------------------------------
;;;
;;; Property Details
;;;
;;; ----------------------------------------------------------------------------
;;; The "area" property
;;;
;;;   "area"                     GtkCellArea*         : Read / Write / Construct
;;;
;;; The GtkCellArea this context was created by
;;;
;;; Since 3.0
;;;
;;; ----------------------------------------------------------------------------
;;; The "minimum-height" property
;;;
;;;   "minimum-height"           gint                  : Read
;;;
;;; The minimum height for the GtkCellArea in this context for all GtkTreeModel
;;; rows that this context was requested for using
;;; gtk_cell_area_get_preferred_height().
;;;
;;; Allowed values: >= G_MAXULONG
;;;
;;; Default value: -1
;;;
;;; Since 3.0
;;;
;;; ----------------------------------------------------------------------------
;;; The "minimum-width" property
;;;
;;;   "minimum-width"            gint                  : Read
;;;
;;; The minimum width for the GtkCellArea in this context for all GtkTreeModel
;;; rows that this context was requested for using
;;; gtk_cell_area_get_preferred_width().
;;;
;;; Allowed values: >= G_MAXULONG
;;;
;;; Default value: -1
;;;
;;; Since 3.0
;;;
;;; ----------------------------------------------------------------------------
;;; The "natural-height" property
;;;
;;;   "natural-height"           gint                  : Read
;;;
;;; The natural height for the GtkCellArea in this context for all GtkTreeModel
;;; rows that this context was requested for using
;;; gtk_cell_area_get_preferred_height().
;;;
;;; Allowed values: >= G_MAXULONG
;;;
;;; Default value: -1
;;;
;;; Since 3.0
;;;
;;; ----------------------------------------------------------------------------
;;; The "natural-width" property
;;;
;;;   "natural-width"            gint                  : Read
;;;
;;; The natural width for the GtkCellArea in this context for all GtkTreeModel
;;; rows that this context was requested for using
;;; gtk_cell_area_get_preferred_width().
;;;
;;; Allowed values: >= G_MAXULONG
;;;
;;; Default value: -1
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkCellAreaContextClass
;;;
;;; struct GtkCellAreaContextClass {
;;;   void (* allocate)                    (GtkCellAreaContext *context,
;;;                                         gint                width,
;;;                                         gint                height);
;;;   void (* reset)                       (GtkCellAreaContext *context);
;;;   void (* get_preferred_height_for_width)
;;;                                        (GtkCellAreaContext *context,
;;;                                         gint                width,
;;;                                         gint               *minimum_height,
;;;                                         gint               *natural_height);
;;;   void (* get_preferred_width_for_height)
;;;                                        (GtkCellAreaContext *context,
;;;                                         gint                height,
;;;                                         gint               *minimum_width,
;;;                                         gint               *natural_width);
;;; };
;;;
;;; allocate ()
;;; 	This tells the context that an allocation width or height (or both) have
;;;     been decided for a group of rows. The context should store any
;;;     allocations for internally aligned cells at this point so that they dont
;;;     need to be recalculated at gtk_cell_area_render() time.
;;;
;;; reset ()
;;; 	Clear any previously stored information about requested and allocated
;;;     sizes for the context.
;;;
;;; get_preferred_height_for_width ()
;;; 	Returns the aligned height for the given width that context must store
;;;     while collecting sizes for it's rows.
;;;
;;; get_preferred_width_for_height ()
;;; 	Returns the aligned width for the given height that context must store
;;;     while collecting sizes for it's rows.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GtkCellAreaContext
;;;
;;; typedef struct _GtkCellAreaContext GtkCellAreaContext;
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCellAreaContext" gtk-cell-area-context
  (:superclass g-object
   :export t
   :interfaces nil
   :type-initializer "gtk_cell_area_context_get_type")
  ((area
    gtk-cell-area-context-area
    "area" "GtkCellArea" t t)
   (minimum-height
    gtk-cell-area-context-minimum-height
    "minimum-height" "gint" t nil)
   (minimum-width
    gtk-cell-area-context-minimum-width
    "minimum-width" "gint" t nil)
   (natural-height
    gtk-cell-area-context-natural-height
    "natural-height" "gint" t nil)
   (natural-width
    gtk-cell-area-context-natural-width
    "natural-width" "gint" t nil)))

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_area ()
;;;
;;; GtkCellArea * gtk_cell_area_context_get_area (GtkCellAreaContext *context);
;;;
;;; Fetches the GtkCellArea this context was created by.
;;;
;;; This is generally unneeded by layouting widgets; however it is important for
;;; the context implementation itself to fetch information about the area it is
;;; being used for.
;;;
;;; For instance at GtkCellAreaContextClass.allocate() time its important to
;;; know details about any cell spacing that the GtkCellArea is configured with
;;; in order to compute a proper allocation.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; Returns :
;;; 	the GtkCellArea this context was created by
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_allocate ()
;;;
;;; void gtk_cell_area_context_allocate (GtkCellAreaContext *context,
;;;                                      gint width,
;;;                                      gint height);
;;;
;;; Allocates a width and/or a height for all rows which are to be rendered with
;;; context.
;;;
;;; Usually allocation is performed only horizontally or sometimes vertically
;;; since a group of rows are usually rendered side by side vertically or
;;; horizontally and share either the same width or the same height. Sometimes
;;; they are allocated in both horizontal and vertical orientations producing a
;;; homogeneous effect of the rows. This is generally the case for GtkTreeView
;;; when "fixed-height-mode" is enabled.
;;;
;;; Since 3.0
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; width :
;;; 	the allocated width for all GtkTreeModel rows rendered with context, or
;;;     -1.
;;;
;;; height :
;;; 	the allocated height for all GtkTreeModel rows rendered with context, or
;;;     -1.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_reset ()
;;;
;;; void gtk_cell_area_context_reset (GtkCellAreaContext *context);
;;;
;;; Resets any previously cached request and allocation data.
;;;
;;; When underlying GtkTreeModel data changes its important to reset the context
;;; if the content size is allowed to shrink. If the content size is only
;;; allowed to grow (this is usually an option for views rendering large data
;;; stores as a measure of optimization), then only the row that changed or was
;;; inserted needs to be (re)requested with gtk_cell_area_get_preferred_width().
;;;
;;; When the new overall size of the context requires that the allocated size
;;; changes (or whenever this allocation changes at all), the variable row sizes
;;; need to be re-requested for every row.
;;;
;;; For instance, if the rows are displayed all with the same width from top to
;;; bottom then a change in the allocated width necessitates a recalculation of
;;; all the displayed row heights using
;;; gtk_cell_area_get_preferred_height_for_width().
;;;
;;; Since 3.0
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_width ()
;;;
;;; void gtk_cell_area_context_get_preferred_width (GtkCellAreaContext *context,
;;;                                                 gint *minimum_width,
;;;                                                 gint *natural_width);
;;;
;;; Gets the accumulative preferred width for all rows which have been requested
;;; with this context.
;;;
;;; After gtk_cell_area_context_reset() is called and/or before ever requesting
;;; the size of a GtkCellArea, the returned values are 0.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; minimum_width :
;;; 	location to store the minimum width, or NULL
;;;
;;; natural_width :
;;; 	location to store the natural width, or NULL
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_height ()
;;;
;;; void gtk_cell_area_context_get_preferred_height
;;;                                                (GtkCellAreaContext *context,
;;;                                                 gint *minimum_height,
;;;                                                 gint *natural_height);
;;;
;;; Gets the accumulative preferred height for all rows which have been
;;; requested with this context.
;;;
;;; After gtk_cell_area_context_reset() is called and/or before ever requesting
;;; the size of a GtkCellArea, the returned values are 0.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; minimum_height :
;;; 	location to store the minimum height, or NULL
;;;
;;; natural_height :
;;; 	location to store the natural height, or NULL
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_height_for_width ()
;;;
;;; void gtk_cell_area_context_get_preferred_height_for_width
;;;                                                (GtkCellAreaContext *context,
;;;                                                 gint width,
;;;                                                 gint *minimum_height,
;;;                                                 gint *natural_height);
;;;
;;; Gets the accumulative preferred height for width for all rows which have
;;; been requested for the same said width with this context.
;;;
;;; After gtk_cell_area_context_reset() is called and/or before ever requesting
;;; the size of a GtkCellArea, the returned values are -1.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; width :
;;; 	a proposed width for allocation
;;;
;;; minimum_height :
;;; 	location to store the minimum height, or NULL
;;;
;;; natural_height :
;;; 	location to store the natural height, or NULL
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_width_for_height ()
;;;
;;; void gtk_cell_area_context_get_preferred_width_for_height
;;;                                                (GtkCellAreaContext *context,
;;;                                                 gint height,
;;;                                                 gint *minimum_width,
;;;                                                 gint *natural_width);
;;;
;;; Gets the accumulative preferred width for height for all rows which have
;;; been requested for the same said height with this context.
;;;
;;; After gtk_cell_area_context_reset() is called and/or before ever requesting
;;; the size of a GtkCellArea, the returned values are -1.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; height :
;;; 	a proposed height for allocation
;;;
;;; minimum_width :
;;; 	location to store the minimum width, or NULL
;;;
;;; natural_width :
;;; 	location to store the natural width, or NULL
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_allocation ()
;;;
;;; void gtk_cell_area_context_get_allocation (GtkCellAreaContext *context,
;;;                                            gint *width,
;;;                                            gint *height);
;;;
;;; Fetches the current allocation size for context.
;;;
;;; If the context was not allocated in width or height, or if the context was
;;; recently reset with gtk_cell_area_context_reset(), the returned value will
;;; be -1.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; width :
;;; 	location to store the allocated width, or NULL
;;;
;;; height :
;;; 	location to store the allocated height, or NULL
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_push_preferred_width ()
;;;
;;; void gtk_cell_area_context_push_preferred_width
;;;                                                (GtkCellAreaContext *context,
;;;                                                 gint minimum_width,
;;;                                                 gint natural_width);
;;;
;;; Causes the minimum and/or natural width to grow if the new proposed sizes
;;; exceed the current minimum and natural width.
;;;
;;; This is used by GtkCellAreaContext implementations during the request
;;; process over a series of GtkTreeModel rows to progressively push the
;;; requested width over a series of gtk_cell_area_get_preferred_width()
;;; requests.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; minimum_width :
;;; 	the proposed new minimum width for context
;;;
;;; natural_width :
;;; 	the proposed new natural width for context
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_push_preferred_height ()
;;;
;;; void gtk_cell_area_context_push_preferred_height
;;;                                                (GtkCellAreaContext *context,
;;;                                                 gint minimum_height,
;;;                                                 gint natural_height);
;;;
;;; Causes the minimum and/or natural height to grow if the new proposed sizes
;;; exceed the current minimum and natural height.
;;;
;;; This is used by GtkCellAreaContext implementations during the request
;;; process over a series of GtkTreeModel rows to progressively push the
;;; requested height over a series of gtk_cell_area_get_preferred_height()
;;; requests.
;;;
;;; context :
;;; 	a GtkCellAreaContext
;;;
;;; minimum_height :
;;; 	the proposed new minimum height for context
;;;
;;; natural_height :
;;; 	the proposed new natural height for context
;;;
;;; Since 3.0
;;; ----------------------------------------------------------------------------


;;; --- End of file gtk.cell-area-context.lisp ---------------------------------