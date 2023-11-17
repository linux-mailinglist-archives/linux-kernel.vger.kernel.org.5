Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78D7EF0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbjKQKnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjKQKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:43:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB4194;
        Fri, 17 Nov 2023 02:43:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9aVIH013102;
        Fri, 17 Nov 2023 10:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TPtLCEPu4isugSYmiQrugFcZCXkM8tpMGDtpsJOlZSY=;
 b=CErGZh159cLgzTM6sU6X9dCkrGwFj395p6dEnCtiLbZg7lgzhEfCfupMKG3ASV7R4Ke8
 jyxnvnJUW8+fvgOSWhyJcM8nVp7TIq7AtG8qN78tg0TpWqqxEynTyOE8/yTp3bArsGvY
 4iexRK+KGAEik69ROevdyQ/ySM8ZshNDfl5hd2m7qUf3pVJH+ngg0UE1uxlXLegA8GKu
 gThxRVEGUszE8kPGExX7sHASJ9xNBCc4cKoDbpJdaWZx1h9QlOoeUYv4cGOjUTmiraPM
 br8PBAys0eNoTaCmMojiLlAaWWFJI1uMVuIv/8n1B1WMesb6Sbf7di11wxuOpN/GWNQ2 TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udpqq2373-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:43:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAhQUl019520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:43:26 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 02:43:21 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Update part number to X1E80100
Date:   Fri, 17 Nov 2023 16:12:54 +0530
Message-ID: <20231117104254.28862-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231117104254.28862-1-quic_sibis@quicinc.com>
References: <20231117104254.28862-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: irju9lyAWALdr30tO9TreW9d5bT0KiTi
X-Proofpoint-ORIG-GUID: irju9lyAWALdr30tO9TreW9d5bT0KiTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace SC8380xp with the updated part number (X1E80100).

Fixes: 2050c9bc4f7b ("pmdomain: qcom: rpmhpd: Add SC8380XP power domains")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index f2e64324deb8..3078896b1300 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -598,8 +598,8 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
 };
 
-/* SC8380xp RPMH powerdomains */
-static struct rpmhpd *sc8380xp_rpmhpds[] = {
+/* X1E80100 RPMH powerdomains */
+static struct rpmhpd *x1e80100_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
 	[RPMHPD_CX_AO] = &cx_ao,
 	[RPMHPD_EBI] = &ebi,
@@ -615,9 +615,9 @@ static struct rpmhpd *sc8380xp_rpmhpds[] = {
 	[RPMHPD_GMXC] = &gmxc,
 };
 
-static const struct rpmhpd_desc sc8380xp_desc = {
-	.rpmhpds = sc8380xp_rpmhpds,
-	.num_pds = ARRAY_SIZE(sc8380xp_rpmhpds),
+static const struct rpmhpd_desc x1e80100_desc = {
+	.rpmhpds = x1e80100_rpmhpds,
+	.num_pds = ARRAY_SIZE(x1e80100_rpmhpds),
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
@@ -629,7 +629,6 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
 	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
-	{ .compatible = "qcom,sc8380xp-rpmhpd", .data = &sc8380xp_desc },
 	{ .compatible = "qcom,sdm670-rpmhpd", .data = &sdm670_desc },
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
@@ -643,6 +642,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm8450-rpmhpd", .data = &sm8450_desc },
 	{ .compatible = "qcom,sm8550-rpmhpd", .data = &sm8550_desc },
 	{ .compatible = "qcom,sm8650-rpmhpd", .data = &sm8650_desc },
+	{ .compatible = "qcom,x1e80100-rpmhpd", .data = &x1e80100_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
-- 
2.17.1

