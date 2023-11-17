Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847E7EF0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbjKQKnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbjKQKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:43:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B12BC;
        Fri, 17 Nov 2023 02:43:25 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9K1r6001816;
        Fri, 17 Nov 2023 10:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fc7cLLjTS6a7sEqedg1fFBDdFMeHLALbgh593IhJHMI=;
 b=X8qS7xJrNJgVe9z3eWeJ1gqOnWZYEM/Gi0WIwBa7YtGOZbLgmeZ8/BcnBvv0U5d21sdB
 gsIw2HKc531t6Mg5ZmmTkJuKfkjbvMrWEJwPMKmXtOxRG2gp2eNJMqeS7UD39yuGacf2
 H2lRAuKxlcPXEEn5QAupMDB5I8Y4wMvC2FDuU1zzlvjTG9jyryT043Y900sZGGGjEUJK
 N91jCdHbtidR/Du8QaOgFi+8W3TRu2ezjwvVaw17v3BJVwhDsA/HnGL7xt2aL5v/th+X
 QiXd3qmMITYwftzAShVCtp1NR5XBn71F8naphgThEOgEin4m86FA86vHrNrO58zFOlrb kA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue5exr5cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:43:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAhLXm014183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:43:21 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 02:43:15 -0800
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
Subject: [PATCH 1/2] dt-bindings: power: rpmpd: Update part number to X1E80100
Date:   Fri, 17 Nov 2023 16:12:53 +0530
Message-ID: <20231117104254.28862-2-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: _ZS56EpCrtMIVkJ0DGZsGQiTYNPN4rAH
X-Proofpoint-ORIG-GUID: _ZS56EpCrtMIVkJ0DGZsGQiTYNPN4rAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxlogscore=918 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170078
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

Fixes: c638b9516abd ("dt-bindings: power: rpmpd: Add SC8380XP support")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index da9c5846f4e1..2ff246cf8b81 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -39,7 +39,6 @@ properties:
           - qcom,sc7280-rpmhpd
           - qcom,sc8180x-rpmhpd
           - qcom,sc8280xp-rpmhpd
-          - qcom,sc8380xp-rpmhpd
           - qcom,sdm660-rpmpd
           - qcom,sdm670-rpmhpd
           - qcom,sdm845-rpmhpd
@@ -57,6 +56,7 @@ properties:
           - qcom,sm8450-rpmhpd
           - qcom,sm8550-rpmhpd
           - qcom,sm8650-rpmhpd
+          - qcom,x1e80100-rpmhpd
       - items:
           - enum:
               - qcom,msm8937-rpmpd
-- 
2.17.1

