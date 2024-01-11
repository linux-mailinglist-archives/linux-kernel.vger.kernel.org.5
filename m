Return-Path: <linux-kernel+bounces-23094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81282A78E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A8B281E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E42592;
	Thu, 11 Jan 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Jj/9k2Tx"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E49256D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=r0vUj6pGIqiH+JcHde
	OSlMJWZuECSyT0n3RL5XfY9A8=; b=Jj/9k2Tx1hOHFZahBwBIiGAPuIam5CaiOD
	lPjqNGa6Z+t/aN6AX1/7/Xtz5Hei5jNbN5d+kor7nKfD+wmaCe/7TF2QqEO9HgzL
	M+FcjLyRoSBWV7S2luKqkGQZcK/7LGtB1Z157eoIt5FlFhcdEvqK8TVCsh3xHQ9/
	TxvmPC+cA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXX79Lip9lMYsyAA--.20534S2;
	Thu, 11 Jan 2024 14:27:23 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in displayobject.h
Date: Thu, 11 Jan 2024 06:27:21 +0000
Message-Id: <20240111062721.8519-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXX79Lip9lMYsyAA--.20534S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFW5trWUJFyxGw1rXFWUArb_yoWxXFW7pF
	1jvr4DArZ5J3WjqrWUX39YvF95Ja1UCr1xKr9xWrnxtr1vg3ZrZr95t348Aa4Iqr4kKF4f
	J3WUGFnxZrW5J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjPfdUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQ1ixWVLYUHeCwAAso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '=' (ctx:WxV)
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/displayobject.h | 72 ++++++++++-----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/displayobject.h b/drivers/gpu/drm/amd/include/displayobject.h
index 0f9529c40496..ce0c13e4e336 100644
--- a/drivers/gpu/drm/amd/include/displayobject.h
+++ b/drivers/gpu/drm/amd/include/displayobject.h
@@ -38,20 +38,20 @@
 * Display Object Type Definition 
 *****************************************************/
 enum display_object_type {
-DISPLAY_OBJECT_TYPE_NONE						=0x00,
-DISPLAY_OBJECT_TYPE_GPU							=0x01,
-DISPLAY_OBJECT_TYPE_ENCODER						=0x02,
-DISPLAY_OBJECT_TYPE_CONNECTOR					=0x03
+DISPLAY_OBJECT_TYPE_NONE = 0x00,
+DISPLAY_OBJECT_TYPE_GPU	= 0x01,
+DISPLAY_OBJECT_TYPE_ENCODER = 0x02,
+DISPLAY_OBJECT_TYPE_CONNECTOR = 0x03
 };
 
 /****************************************************
 * Encorder Object Type Definition 
 *****************************************************/
 enum encoder_object_type {
-ENCODER_OBJECT_ID_NONE							 =0x00,
-ENCODER_OBJECT_ID_INTERNAL_UNIPHY				 =0x01,
-ENCODER_OBJECT_ID_INTERNAL_UNIPHY1				 =0x02,
-ENCODER_OBJECT_ID_INTERNAL_UNIPHY2				 =0x03,
+ENCODER_OBJECT_ID_NONE = 0x00,
+ENCODER_OBJECT_ID_INTERNAL_UNIPHY = 0x01,
+ENCODER_OBJECT_ID_INTERNAL_UNIPHY1 = 0x02,
+ENCODER_OBJECT_ID_INTERNAL_UNIPHY2 = 0x03,
 };
 
 
@@ -60,14 +60,14 @@ ENCODER_OBJECT_ID_INTERNAL_UNIPHY2				 =0x03,
 *****************************************************/
 
 enum connector_object_type {
-CONNECTOR_OBJECT_ID_NONE						  =0x00, 
-CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D			  =0x01,
-CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D				  =0x02,
-CONNECTOR_OBJECT_ID_HDMI_TYPE_A					  =0x03,
-CONNECTOR_OBJECT_ID_LVDS						  =0x04,
-CONNECTOR_OBJECT_ID_DISPLAYPORT					  =0x05,
-CONNECTOR_OBJECT_ID_eDP							  =0x06,
-CONNECTOR_OBJECT_ID_OPM							  =0x07
+CONNECTOR_OBJECT_ID_NONE = 0x00, 
+CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D = 0x01,
+CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D = 0x02,
+CONNECTOR_OBJECT_ID_HDMI_TYPE_A = 0x03,
+CONNECTOR_OBJECT_ID_LVDS = 0x04,
+CONNECTOR_OBJECT_ID_DISPLAYPORT	= 0x05,
+CONNECTOR_OBJECT_ID_eDP = 0x06,
+CONNECTOR_OBJECT_ID_OPM = 0x07
 };
 
 
@@ -81,24 +81,24 @@ CONNECTOR_OBJECT_ID_OPM							  =0x07
 *****************************************************/
 
 enum object_enum_id {
-OBJECT_ENUM_ID1									  =0x01,
-OBJECT_ENUM_ID2									  =0x02,
-OBJECT_ENUM_ID3									  =0x03,
-OBJECT_ENUM_ID4									  =0x04,
-OBJECT_ENUM_ID5									  =0x05,
-OBJECT_ENUM_ID6									  =0x06
+OBJECT_ENUM_ID1 = 0x01,
+OBJECT_ENUM_ID2 = 0x02,
+OBJECT_ENUM_ID3 = 0x03,
+OBJECT_ENUM_ID4 = 0x04,
+OBJECT_ENUM_ID5	= 0x05,
+OBJECT_ENUM_ID6	= 0x06
 };
 
 /****************************************************
 *Object ID Bit definition 
 *****************************************************/
 enum object_id_bit {
-OBJECT_ID_MASK									  =0x00FF,
-ENUM_ID_MASK									  =0x0F00,
-OBJECT_TYPE_MASK								  =0xF000,
-OBJECT_ID_SHIFT									  =0x00,
-ENUM_ID_SHIFT									  =0x08,
-OBJECT_TYPE_SHIFT								  =0x0C
+OBJECT_ID_MASK = 0x00FF,
+ENUM_ID_MASK = 0x0F00,
+OBJECT_TYPE_MASK = 0xF000,
+OBJECT_ID_SHIFT = 0x00,
+ENUM_ID_SHIFT = 0x08,
+OBJECT_TYPE_SHIFT = 0x0C
 };
 
 
@@ -106,7 +106,7 @@ OBJECT_TYPE_SHIFT								  =0x0C
 * GPU Object definition - Shared with BIOS
 *****************************************************/
 enum gpu_objet_def {
-GPU_ENUM_ID1                            = (DISPLAY_OBJECT_TYPE_GPU << OBJECT_TYPE_SHIFT | OBJECT_ENUM_ID1 << ENUM_ID_SHIFT)
+GPU_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_GPU << OBJECT_TYPE_SHIFT | OBJECT_ENUM_ID1 << ENUM_ID_SHIFT)
 };
 
 /****************************************************
@@ -114,27 +114,27 @@ GPU_ENUM_ID1                            = (DISPLAY_OBJECT_TYPE_GPU << OBJECT_TYP
 *****************************************************/
 
 enum encoder_objet_def {
-ENCODER_INTERNAL_UNIPHY_ENUM_ID1         = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY << OBJECT_ID_SHIFT),
 
-ENCODER_INTERNAL_UNIPHY_ENUM_ID2         = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY_ENUM_ID2 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY << OBJECT_ID_SHIFT),
 
-ENCODER_INTERNAL_UNIPHY1_ENUM_ID1        = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY1_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY1 << OBJECT_ID_SHIFT),
 
-ENCODER_INTERNAL_UNIPHY1_ENUM_ID2        = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY1_ENUM_ID2 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY1 << OBJECT_ID_SHIFT),
 
-ENCODER_INTERNAL_UNIPHY2_ENUM_ID1        = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY2_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY2 << OBJECT_ID_SHIFT),
 
-ENCODER_INTERNAL_UNIPHY2_ENUM_ID2        = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
+ENCODER_INTERNAL_UNIPHY2_ENUM_ID2 = (DISPLAY_OBJECT_TYPE_ENCODER << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
                                                  ENCODER_OBJECT_ID_INTERNAL_UNIPHY2 << OBJECT_ID_SHIFT)
 };
@@ -151,7 +151,7 @@ CONNECTOR_LVDS_ENUM_ID1	= (DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_TYPE_SHIFT |\
                                                  CONNECTOR_OBJECT_ID_LVDS << OBJECT_ID_SHIFT),
 
 
-CONNECTOR_eDP_ENUM_ID1	= (DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_TYPE_SHIFT |\
+CONNECTOR_eDP_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
                                                  CONNECTOR_OBJECT_ID_eDP << OBJECT_ID_SHIFT),
 
-- 
2.17.1


