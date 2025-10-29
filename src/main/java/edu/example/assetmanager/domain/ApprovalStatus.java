package edu.example.assetmanager.domain;

public enum ApprovalStatus {
    PENDING("대기중","waited"),
    FIRST_APPROVAL("처리중","waited"),
    FINAL_APPROVAL("승인됨","approved"),
    FIRST_REJECT("반려됨","rejected"),
    LAST_REJECT("반려됨","rejected");

    private final String koreanName;
    private final String lowerCase;

    ApprovalStatus(String koreanName, String lowerCase) {
        this.koreanName = koreanName;
        this.lowerCase = lowerCase;
    }
    
    public String getKoreanName() {
    	return this.koreanName;
    }
    
    public String getLowerCase() {
    	return this.lowerCase;
    }
    
    // DString → Enum 변환
    public static ApprovalStatus from(String dbValue) {
        for (ApprovalStatus status : values()) {
            if (status.name().equalsIgnoreCase(dbValue)) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown OrderStatus: " + dbValue);
    }
}
