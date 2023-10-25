Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9F7D69AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjJYLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjJYLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:01:46 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 04:01:38 PDT
Received: from 7.mo576.mail-out.ovh.net (7.mo576.mail-out.ovh.net [46.105.50.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CE1A5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:01:38 -0700 (PDT)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.143.210])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A75E826F4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:26:31 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-26h4r (unknown [10.110.115.240])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 23FD11FE5F;
        Wed, 25 Oct 2023 10:26:31 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.99])
        by ghost-submission-6684bf9d7b-26h4r with ESMTPSA
        id um1WBFftOGV4gwAARm6H6g
        (envelope-from <wiktor.grzywacz@3mdeb.com>); Wed, 25 Oct 2023 10:26:31 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-99G003f3ccc1a6-09ce-433e-8256-0378fa1aff91,
                    14A0AEEFCB3B0BFA38FE34D53745A0BBD0B19B92) smtp.auth=wiktor.grzywacz@3mdeb.com
X-OVh-ClientIp: 213.192.77.249
From:   Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
Subject: [PATCH] Signed-off-by: Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
Date:   Wed, 25 Oct 2023 12:24:20 +0200
Message-ID: <20231025102614.125291-1-wiktor.grzywacz@3mdeb.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17102138111644632453
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhephghikhhtohhrucfirhiihiifrggtiicuoeifihhkthhorhdrghhriiihfigrtgiiseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpeffgfetheeftdehveeiveehfeeljeeijeekudeiieeifedvheekteevteetgfekheenucfkphepuddvjedrtddrtddruddpvddufedrudelvddrjeejrddvgeelpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeifihhkthhorhdrghhriiihfigrtgiiseefmhguvggsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

staging: rtl8723bs: fix checkpatch space before tab warning
---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 2028791988e7..8bdb685c10e7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -46,7 +46,7 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_CUT_VER, cut_ver);
 
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_PATCH_ID, pHalData->CustomerID);
-	/* 	ODM_CMNINFO_BINHCT_TEST only for MP Team */
+	/*  ODM_CMNINFO_BINHCT_TEST only for MP Team */
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
 
 	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
@@ -84,7 +84,7 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
 	/*  Pointer reference */
 	/*  */
 	/* ODM_CMNINFO_MAC_PHY_MODE pHalData->MacPhyMode92D */
-	/* 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MAC_PHY_MODE,&(pDM_Odm->u8_temp)); */
+	/*  ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MAC_PHY_MODE,&(pDM_Odm->u8_temp)); */
 
 	ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-- 
2.41.0

