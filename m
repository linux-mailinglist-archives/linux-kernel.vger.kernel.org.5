Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B676B93C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjHAP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHAP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:58:51 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A4BF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:58:50 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371C55JE004120;
        Tue, 1 Aug 2023 15:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=wHJkRC/1rxNknMvwCpmNDyxOiRsBvdAnVRARJspLqVo=;
 b=B8f0a7CRI07WhEgXZctfgeudevJgQoduoWVC0Meb0r9gmxuPPfKYm4X2vd8TYYPFqTKm
 IUX3nX8jFjF11iqhvirSNqDxRMyefB4Zk16jv4XXKtsErU3c6iexYIraO4XO6az1SLgo
 v7bKc1Ub4l4jaxplvnHZErtuOIKcaasKyIKMh8Dhyjy8xBo6C11d9yeKUwIsKCyTW1pp
 u8iVoaWlZVHWt56dPD0leUrAHhCU8pLtjTTcnzXzYJQvOK2nZDlHTplWtAXnPV3uszIo
 SJo31eEsLVNRQX9qLcfj0sxcVKm76K5I52zCPzAuPCU86t6Yio69nyTOO2pqr+m7sjVl Hg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s6wnfckc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 15:58:15 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6ECBB147A3;
        Tue,  1 Aug 2023 15:58:14 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 05BBC80BA2E;
        Tue,  1 Aug 2023 15:58:14 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 982F530393F; Tue,  1 Aug 2023 10:58:13 -0500 (CDT)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH] Update HPE Superdome Flex Maintainers
Date:   Tue,  1 Aug 2023 10:57:56 -0500
Message-Id: <20230801155756.22308-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a6dRsFvQrJv_fnzqWi2SEo7oqltqL8gi
X-Proofpoint-ORIG-GUID: a6dRsFvQrJv_fnzqWi2SEo7oqltqL8gi
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Travis has retired. His expertise will be sorely missed.
Remove Mike's entry under SGI XP/XPC/XPNET DRIVER.
Replace Mike's entry under UV HPE SUPERDOME FLEX.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53b7ca804465..db3dce00a274 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19285,7 +19285,6 @@ F:	drivers/misc/sgi-gru/
 SGI XP/XPC/XPNET DRIVER
 M:	Robin Holt <robinmholt@gmail.com>
 M:	Steve Wahl <steve.wahl@hpe.com>
-R:	Mike Travis <mike.travis@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-xp/
 
@@ -23144,7 +23143,8 @@ F:	arch/x86/platform
 
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
-R:	Mike Travis <mike.travis@hpe.com>
+R:	Justin Ernst <justin.ernst@hpe.com>
+R:	Kyle Meyer <kyle.meyer@hpe.com>
 R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 R:	Russ Anderson <russ.anderson@hpe.com>
 S:	Supported
-- 
2.35.3

