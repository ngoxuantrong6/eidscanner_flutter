package com.example.eidscanner_flutter;
import java.util.ArrayList;
import java.util.List;

import vn.gtel.eidsdk.data.Eid;

public class OnboardDataManager {

    public static OnboardDataManager shared = OnboardDataManager.getInstance();

    private static volatile OnboardDataManager _instance = null;

    public String eidImagePathFront = "";
    public String eidImagePathBack = "";
    public String selfiePath = "";
    public String cloudEidImageFrontUrl = "";
    public String cloudEidImageBackUrl = "";
    public String cloudSelfieUrl = "";
    public Eid eid = null;
    public List<String> listFacePath = new ArrayList<>();

    synchronized private static OnboardDataManager getInstance() {
        if (_instance == null) {
            _instance = new OnboardDataManager();
        }
        return _instance;
    }

    public void clear() {
        eidImagePathFront = "";
        eidImagePathBack = "";
        selfiePath = "";
        cloudEidImageFrontUrl = "";
        cloudEidImageBackUrl = "";
        cloudSelfieUrl = "";
        listFacePath = new ArrayList<>();
    }

}
