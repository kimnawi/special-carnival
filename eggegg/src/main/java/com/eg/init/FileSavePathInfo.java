package com.eg.init;

import java.io.File;

public interface FileSavePathInfo {
	/**
	 * 사원 프로필 이미지 상위 url
	 * @return
	 */
	public String getEmplImagesUrl();
	/**
	 * 사원 프로필 실제 저장 위치
	 * @return
	 */
	public File getEmplSaveFolder();
}
