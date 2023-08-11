Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19346779963
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjHKV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjHKV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:26:27 -0400
X-Greylist: delayed 3285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 14:26:27 PDT
Received: from mx0b-00000d04.pphosted.com (mx0b-00000d04.pphosted.com [148.163.153.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8452129;
        Fri, 11 Aug 2023 14:26:26 -0700 (PDT)
Received: from pps.filterd (m0102895.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BHHm1r027680;
        Fri, 11 Aug 2023 13:31:32 -0700
Received: from mx0b-00000d06.pphosted.com (mx0b-00000d06.pphosted.com [148.163.139.119])
        by mx0a-00000d04.pphosted.com (PPS) with ESMTPS id 3sd8yt4508-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:31:32 -0700
Received: from pps.filterd (m0195433.ppops.net [127.0.0.1])
        by mx0a-00000d06.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BBRjtc029506;
        Fri, 11 Aug 2023 13:31:31 -0700
Received: from smtp.stanford.edu (smtp5.stanford.edu [171.67.219.71])
        by mx0a-00000d06.pphosted.com (PPS) with ESMTPS id 3s9k74g6jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:31:31 -0700
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 86856141728;
        Fri, 11 Aug 2023 13:31:30 -0700 (PDT)
Received: from DNa8006b2.SUNet ([10.128.6.178])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 37BKVFul009170
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Aug 2023 13:31:27 -0700
From:   Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
Subject: [PATCH] hid: Add "Hailuck" to the list of non-apple apple keyboards
Date:   Fri, 11 Aug 2023 13:29:31 -0700
Message-ID: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
x-proofpoint-stanford-dir: outbound
X-Proofpoint-ORIG-GUID: -kG0HUuj5cXvzlysfqfSvdzvd0VFymOA
X-Proofpoint-GUID: -kG0HUuj5cXvzlysfqfSvdzvd0VFymOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=100 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110189
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powzan keyboards KB750 and KB770 identify as
"Hailuck Co.,Ltd USB Keyboard". Adding "Hailuck" to the list
of non-apple apple keyboards fixes function keys for these models.

Signed-off-by: Nils Tonnaett <ntonnatt@ccrma.stanford.edu>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d7b932925730..6664f90cecaf 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -343,7 +343,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "SONiX USB DEVICE" },
 	{ "Keychron" },
 	{ "AONE" },
-	{ "GANSS" }
+	{ "GANSS" },
+	{ "Hailuck" }
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.41.0

