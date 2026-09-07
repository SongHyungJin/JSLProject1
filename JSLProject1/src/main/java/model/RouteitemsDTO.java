package model;

public class RouteitemsDTO {

    private int id;
    private int routes_id;
    private int places_id;
    private int day_number;
    private int visit_order;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoutes_id() {
        return routes_id;
    }

    public void setRoutes_id(int routes_id) {
        this.routes_id = routes_id;
    }

    public int getPlaces_id() {
        return places_id;
    }

    public void setPlaces_id(int places_id) {
        this.places_id = places_id;
    }

    public int getDay_number() {
        return day_number;
    }

    public void setDay_number(int day_number) {
        this.day_number = day_number;
    }

    public int getVisit_order() {
        return visit_order;
    }

    public void setVisit_order(int visit_order) {
        this.visit_order = visit_order;
    }
}
