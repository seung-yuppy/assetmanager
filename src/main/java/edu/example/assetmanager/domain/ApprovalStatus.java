package edu.example.assetmanager.domain;

public enum ApprovalStatus {
    PENDING("대기중"),
    FIRST_APPROVAL("1차 승인"),
    FINAL_APPROVAL("최종 승인"),
    FIRST_REJECT("1차 반려"),
    LAST_REJECT("최종 반려");

    private final String koreanName;

    ApprovalStatus(String koreanName) {
        this.koreanName = koreanName;
    }
    
    public String getKoreanName() {
    	return this.koreanName;
    }
    
    // 소문자 변환
    public String toLower() {
        return this.name().toLowerCase();
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
