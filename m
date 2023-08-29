Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF978C83F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjH2PDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbjH2PDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:03:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BBCD6;
        Tue, 29 Aug 2023 08:03:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TEI44D016856;
        Tue, 29 Aug 2023 15:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=Pbq2qERGO+nLC19TWRCJXsINUbgJX/x606S2q8/ClPo=;
 b=bPNU3Kj+bylG5NGOXVuyFvPRaiEckhrhIsblK+kOJiyY1xRWZ0StFg2KXvAPtYdW5SMX
 3SQeBP/9H3XDqJ2eWjVMp5wbuYso3/mHp2iSdnCzMWW4ten/VJJ8i+Dp5v29UuF1ckIn
 U5O4TfZqxhij284LzOntiJAZFykE0kukGvmq2wg+bd+L3uURyBzZNmSsyLALvSsbWxly
 kOnwtU15ayl2W34F5XZz+gCGWGTueu9Q+Bzq2wYc3t6e4s106PrEn8VagRyffkzlwUwQ
 8rsjwKE+GsV3gDWK3OAKrFbA8pmZeLxiev6a+F66p2Nq45BRdgYJSUuPzZ0PdGRJ86kA Fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr23yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:03:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TF3bag029721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:03:37 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 08:03:37 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 29 Aug 2023 08:03:33 -0700
Subject: [PATCH] MAINTAINERS: wifi: ath12k: add wiki link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230829-ath12kwiki-v1-1-df37127527a1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMQI7mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMj3cSSDEOj7PLM7Exdy1QTY8OkVCOjFEtDJaCGgqLUtMwKsGHRsbW
 1AKOFOVBcAAAA
To:     <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
CC:     Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wOi3xHM6Pw__XqnpSHK-yA2yfNhzc_qW
X-Proofpoint-ORIG-GUID: wOi3xHM6Pw__XqnpSHK-yA2yfNhzc_qW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=687
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ath12k wireless driver now has a wiki, so advertise it.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d613b549c7a4..cde457a17a4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17475,6 +17475,7 @@ M:	Kalle Valo <kvalo@kernel.org>
 M:	Jeff Johnson <quic_jjohnson@quicinc.com>
 L:	ath12k@lists.infradead.org
 S:	Supported
+W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath12k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath12k/
 

---
base-commit: 1ad27e0f35db54b6804b8b2dbbe7e35eb4bbe67f
change-id: 20230822-ath12kwiki-9e431be22d91

