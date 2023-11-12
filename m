Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12A7E9245
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjKLTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:36:33 -0500
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 11:36:29 PST
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF3187
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:36:29 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.156.29])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 0356028529
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:57:13 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mr4fc (unknown [10.110.208.237])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5C52C1FE68;
        Sun, 12 Nov 2023 18:57:13 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.106])
        by ghost-submission-6684bf9d7b-mr4fc with ESMTPSA
        id G4wKEgkgUWVPbgEAXATW5Q
        (envelope-from <wiktor.grzywacz@3mdeb.com>); Sun, 12 Nov 2023 18:57:13 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-106R0060453ac51-21fb-4da3-8799-e44204b9f805,
                    04505B612A48EC5E7F489E822CE31C5834F35F42) smtp.auth=wiktor.grzywacz@3mdeb.com
X-OVh-ClientIp: 213.192.64.75
From:   Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix checkpatch no spaces before tabs warning
Date:   Sun, 12 Nov 2023 19:57:10 +0100
Message-Id: <20231112185710.101990-1-wiktor.grzywacz@3mdeb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2308376284534834651
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvkedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhkthhorhcuifhriiihfigrtgiiuceofihikhhtohhrrdhgrhiihiifrggtiiesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdvueekledtjeetkeelffdukedtffduveefieefleetieetheehtefgtdegvefgnecukfhppeduvdejrddtrddtrddupddvudefrdduledvrdeigedrjeehpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeofihikhhtohhrrdhgrhiihiifrggtiiesfehmuggvsgdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some old commented out code, that triggers
a checkpatch.pl no spaces before tabs warning.

Signed-off-by: Wiktor Grzywacz <wiktor.grzywacz@3mdeb.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 2028791988e7..eb4e4f44d4cb 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -46,7 +46,6 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_CUT_VER, cut_ver);
 
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_PATCH_ID, pHalData->CustomerID);
-	/* 	ODM_CMNINFO_BINHCT_TEST only for MP Team */
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
 
 	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
@@ -83,8 +82,6 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
 	/*  */
 	/*  Pointer reference */
 	/*  */
-	/* ODM_CMNINFO_MAC_PHY_MODE pHalData->MacPhyMode92D */
-	/* 	ODM_CmnInfoHook(pDM_Odm, ODM_CMNINFO_MAC_PHY_MODE,&(pDM_Odm->u8_temp)); */
 
 	ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-- 
2.34.1

