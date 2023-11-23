Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA27F5BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjKWKBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjKWKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:00:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF48D50;
        Thu, 23 Nov 2023 02:00:57 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5v4jV003615;
        Thu, 23 Nov 2023 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A34VGd8JVRrQflr3ztmyHdtrOC8Y0gDNtrj/F4tOLLo=;
 b=ElTmP8AWTjz9N6o4iFl3rsQaUeKLfAKhCsYJ9usA/695ywWVsmV04vT0fnFYX/EJeVSc
 ORn0DtppfUn2TTJLfcXvSyzqx9PAQkiwkhVuBDawFFaGbC2PiSHM1CcsVuNAAY36ANtD
 YYR+2br5ZiHB4Rq/10FLb1340sTjpsfFnOyzuL7L+iKaqatjdjYCxzFzcPKzVezgjD4m
 fca3+zB3S0izrht7sJkmHYjd7DbsRA+IeAOke39juJHEbFFNGbeXZbIB18AB8LXdjz+x
 dfawyWldT6ihnAxmYHiTGB7lYtPScsToX1vJSpBEAVweSLVd80tF2N4EVGrzISoJRBVX 7w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhey5aygh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:00:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANA0ptK016211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:00:51 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 02:00:46 -0800
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
Subject: [PATCH V2 1/2] dt-bindings: power: rpmpd: Update part number to X1E80100
Date:   Thu, 23 Nov 2023 15:30:20 +0530
Message-ID: <20231123100021.10918-2-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wZUyocxFq3CkiPOyB87KDY42k_w6n-I0
X-Proofpoint-GUID: wZUyocxFq3CkiPOyB87KDY42k_w6n-I0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230070
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
a result of which the SC8380xp rpmpd bindings introduced is no longer
correct. Given that it currently has no users, it was agreed that it
can be updated to the correct part number (X1E80100) without causing
any binding breakage.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Add more details to the commit message. [Krzysztof/Konrad]

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

