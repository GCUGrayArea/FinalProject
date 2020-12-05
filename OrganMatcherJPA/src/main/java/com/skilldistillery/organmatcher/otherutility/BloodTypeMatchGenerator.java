package com.skilldistillery.organmatcher.otherutility;

public class BloodTypeMatchGenerator {
	
	// This script is not useful to the web app. I (Gray) created it to easily 
	// generate a table of blood type compatibilities after realizing it would
	// be needed.

	public static void main(String[] args) {
		int[] id = { 1 , 2 , 3 , 4 , 5, 6 , 7 , 8 };
		char[] grp = { 'A' , 'A' , 'B' , 'B' , 'X' , 'X', 'O' , 'O' };
		boolean[] rh = { true , false , true , false , true , false, true , false };
		
		BloodType[] types = new BloodType[8];
		for ( int i = 0 ; i < 8 ; i++ ) {
			types[i] = new BloodType();
			types[i].id = id[i];
			types[i].bloodGroup = grp[i];
			types[i].rh = rh[i];
		}
		
		for ( int i = 0 ; i < types.length ; i++ ) {
			for ( int j = 0 ; j < types.length ; j++ ) {
				if ( types[i].canAccept(types[j] ) ) {
					System.out.println(types[i].id + "\t" + types[j].id);
				}
			}
		}
	}

}

class BloodType {
	int id;
	char bloodGroup;
	boolean rh;
	
	char getBloodGroup() {
		return this.bloodGroup;
	}
	
	boolean isRh() {
		return this.rh;
	}
	
	boolean canAccept( BloodType other ) {
	//X (AB) can accept any group, but must match otherwise
		if ( this.bloodGroup != 'X' && this.bloodGroup != other.getBloodGroup() ) {
			return false;
		}
		//negative people can't accept positive blood
		if ( !this.isRh() && other.isRh() ) {
			return false;
		}

		return true; //if ABO and Rh haven't disqualified
	}
}
