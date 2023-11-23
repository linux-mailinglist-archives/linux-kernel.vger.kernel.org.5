Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD17F5BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjKWKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjKWKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:01:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D01A4;
        Thu, 23 Nov 2023 02:01:28 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN6J7Uw012365;
        Thu, 23 Nov 2023 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=x2VHDcxFejIyKJ8k3+tPniadkU0vP7hUQoICBOL2JoY=;
 b=LrHfQCbwhbvhA/234A0y8EvJrOyWLrxi0sOKKBFIOR8SnNjKWMrtg4kzkE2TzdG1uGCb
 msHhVWg7rUepI9GewV6P8NWcxVc1y0Iwoj1QNvVRBe3S4n0sDTaofLa2y8/MBxOjujub
 27L+9LmGW9miHgHANEgwIjUJqR/j9Zn7uXzvEDGfLdHCKe1k1hi9m61byjqYVRz98krL
 pINZAYbjY3GEggpgSfJT+eqdhSYHY/GZ2UD/0/gZO08gY5EYEBZVJY44tAuw66As30UV
 U7ZcFA0HobxfLmHYLtaUtQPaekGvl/98Z3m5EFDGXnY+VeQFXFdG3J9ZF21qmuv6ULUN YA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhkfnt9mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:01:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANA0uTS016116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:00:56 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 02:00:51 -0800
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
Subject: [PATCH V2 2/2] pmdomain: qcom: rpmhpd: Update part number to X1E80100
Date:   Thu, 23 Nov 2023 15:30:21 +0530
Message-ID: <20231123100021.10918-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100021.10918-1-quic_sibis@quicinc.com>
References: <20231123100021.10918-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0QBcPCXLdPuLFpi7PdASVLmfDxUWKCBY
X-Proofpoint-ORIG-GUID: 0QBcPCXLdPuLFpi7PdASVLmfDxUWKCBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a recent part number update from SC8380XP to X1E80100 and as
a result of which SC8380xp prefix introduced in the rpmhpd driver is no
longer correct. Update it to X1E80100, to reflect the bindings change.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Add more details to the commit message. [Krzysztof/Konrad]

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

