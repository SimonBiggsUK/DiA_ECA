class UserC {
  HashMap mJoints;
  int mUserId;
  UserC(int _userId) {
    mUserId=_userId;
    mJoints=new HashMap();
  }
  void addJoint(String _key, PVector _val) {
    mJoints.put(_key, _val);
  }

  void paint() {
    setupCamera();
    PVector jointP1=(PVector)mJoints.get("SKEL_HEAD");
    PVector jointP2=(PVector) mJoints.get("SKEL_NECK");
    if(jointP1!=null && jointP2!=null){
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);
    println("arrrr");
  }

    jointP1=(PVector)mJoints.get("SKEL_NECK");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_SHOULDER");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_LEFT_SHOULDER");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_ELBOW");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_LEFT_ELBOW");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_HAND");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_NECK");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_SHOULDER");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_RIGHT_SHOULDER");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_ELBOW");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_RIGHT_ELBOW");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_HAND");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_LEFT_SHOULDER");
    jointP2=(PVector) mJoints.get("SKEL_TORSO");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_RIGHT_SHOULDER");
    jointP2=(PVector) mJoints.get("SKEL_TORSO");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_TORSO");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_HIP");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_LEFT_HIP");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_KNEE");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_LEFT_KNEE");
    jointP2=(PVector) mJoints.get("SKEL_LEFT_FOOT");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_TORSO");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_HIP");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_RIGHT_HIP");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_KNEE");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);

    jointP1=(PVector)mJoints.get("SKEL_RIGHT_KNEE");
    jointP2=(PVector) mJoints.get("SKEL_RIGHT_FOOT");
        if(jointP1!=null && jointP2!=null)
    line(jointP1.x, jointP1.y, jointP1.z, jointP2.x, jointP2.y, jointP2.z);
  }
}

