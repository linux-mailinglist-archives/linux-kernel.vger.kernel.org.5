Return-Path: <linux-kernel+bounces-22953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FC82A5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9369D1F24276
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858C2116;
	Thu, 11 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kCVHS4pt"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1120E0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=y6vDa0DRaabKBySXAU
	ICJ5fEtOO8azvWflhkmAQ8vOg=; b=kCVHS4ptLgNfAVw7b48qFG1QK0YIuxdl3i
	d2YVZZBHOSY84bx32kZzP2kA+wkEXplg4slEypmtkpw5P3+PEftf5VM87zYa4Ajf
	cF1knzLybYQHrPoQzIWYWoopLq0vTaZ2TiegmfK3TqfHSfwklnoGQ8oI4BYy2TEA
	4hAM9qvDA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnr615TJ9l1gYtAA--.11544S2;
	Thu, 11 Jan 2024 10:03:37 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd/amdgpu: Clean up errors in amdgpu_umr.h
Date: Thu, 11 Jan 2024 02:03:33 +0000
Message-Id: <20240111020333.5611-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnr615TJ9l1gYtAA--.11544S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47ZF1rJw1rAw4ruF45Wrg_yoWfZFc_C3
	yUCa47Xry3XFnIv3W29rWrXr1Dt3WrCFs7Wr1ftasayryxu34UXa4DCry7Xa1I9FnxCF1q
	q3WFgF15Z3ZrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU5CztUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHABixWV2zz4NxQABsQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

spaces required around that '=' (ctx:VxV)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
index 107f9bb0e24f..5b27fc41ffbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
@@ -69,12 +69,12 @@ struct amdgpu_debugfs_gprwave_data {
 };
 
 enum AMDGPU_DEBUGFS_REGS2_CMDS {
-	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
+	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE = 0,
 	AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE_V2,
 };
 
 enum AMDGPU_DEBUGFS_GPRWAVE_CMDS {
-	AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE=0,
+	AMDGPU_DEBUGFS_GPRWAVE_CMD_SET_STATE = 0,
 };
 
 //reg2 interface
-- 
2.17.1


