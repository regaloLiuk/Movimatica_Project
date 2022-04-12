package com.movimatica.jmg.model;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class Translator {

    public static HashMap<String,String> toMap(JSONObject json){
        JSONArray labels = (JSONArray) json.get("labels");
        HashMap<String,String> hm = new HashMap<String, String>();
        for(int i=0; i<labels.size();i++){
            JSONObject j = (JSONObject) labels.get(i);
            hm.put(j.get("code").toString(),j.get("value").toString());
        }
        System.out.println(hm);
        return hm ;
    }
    public static HashMap<String,String> toMap(String s) {
        HashMap<String, String> hm = new HashMap<String, String>();
        try {
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(s);
            JSONArray labels = (JSONArray) json.get("labels");
            for (Object label : labels) {
                JSONObject j = (JSONObject) label;
                hm.put(j.get("code").toString(), j.get("value").toString());
            }
        }catch (ParseException e){  System.out.println(e.getMessage()); }
        System.out.println(hm);
        return hm ;
    }

    public static JSONObject toJson(HashMap<String,String> map){
        JSONParser parser = new JSONParser();
        JSONObject result = null;
        try {
            String json = "{\"labels\":[";
            for(Map.Entry<String,String> entry : map.entrySet())
                json+="{\"code\":" + "\"" + entry.getKey() + "\"" + ",\"value\":" + "\"" + entry.getValue() + "\"}";
            json+="]}";
            result = (JSONObject) parser.parse(json);
        }catch (ParseException e){  System.out.println(e.getMessage()); }
        return result;

    }
}
