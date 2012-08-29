class UserC{
  HashMap mJoints;
  int mUserId;
  UserC(int _userId){
    mUserId=_userId;
    mJoints=new HashMap();
  }
  void addJoint(String _key, PVector _val){
    mJoints.put(_key,_val);
  }
  
  void paint(){
    println("SKEL_LEFT_SHOULDER : " + mJoints.get("SKEL_LEFT_SHOULDER"));
  }
}
