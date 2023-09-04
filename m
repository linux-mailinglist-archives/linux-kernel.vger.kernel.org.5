Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0D791129
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352306AbjIDFvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352303AbjIDFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:50:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38A103;
        Sun,  3 Sep 2023 22:50:54 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3843F6ZB009342;
        Mon, 4 Sep 2023 05:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OidOuEeHwvTWTstDMB6aXlGb/mdxwTzx1wHxAbFI7pw=;
 b=lKdB861jfXp5XTsFmq2x/FTwSJoW0/K4a2Hue0VQ53oSqMhHLCv0tj+chlYybgacSMY3
 xdoupWjArL6Axp2pgfrufuv6adqu0DUokVyqPlQVCNbAoxKdXD1KmVL+BHMB2B/Ongku
 XNOopZLBMXtVK1TyBsaYVtACnaDwMZCFNrDbeWfPk1EBDGgVvVtqhiUIQ/YHVJV7KSWr
 AoiSS/mYGpN6OQxA6c0hqZntwrOGWwMWnx7h+ucQs87nmTmAjy8/DhwaQNOWmjlXXT0V
 cgMztA8tWzEPig3q5ChMo2SfJbKQQLQEvH7DlzTLX63ofXk4JAomWK1mnkkvqMMZNMe6 fA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw99avtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 05:50:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3845oki0025998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 05:50:46 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 3 Sep 2023 22:50:41 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH 3/3] dt-bindings: hwlock: Drop unused qcom,ipq6018-tcsr-mutex
Date:   Mon, 4 Sep 2023 11:20:10 +0530
Message-ID: <20230904055010.4118982-4-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UT38wzCvhoO31iPmE9OixILSXv69WUTD
X-Proofpoint-ORIG-GUID: UT38wzCvhoO31iPmE9OixILSXv69WUTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=845 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop qcom,ipq6018-tcsr-mutex enum as this is does not map to the correct
config for IPQ6018. IPQ6018 will use qcom,tcsr-mutex compatible string.

Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
index ee2726149cf3..a595396fd3f9 100644
--- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -22,7 +22,6 @@ properties:
       - items:
           - enum:
               - qcom,apq8084-tcsr-mutex
-              - qcom,ipq6018-tcsr-mutex
               - qcom,msm8226-tcsr-mutex
               - qcom,msm8994-tcsr-mutex
           - const: qcom,tcsr-mutex
-- 
2.41.0

