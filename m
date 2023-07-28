Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A467663DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjG1GDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjG1GDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:03:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A48271D;
        Thu, 27 Jul 2023 23:03:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1gHAp008494;
        Fri, 28 Jul 2023 06:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7+9oIDVZ4iHF5uAqJ4m0LXvPESLhYEkJLouB8LuXRFM=;
 b=kPE3XgzzDKn+B9rAaMtCWHD7f+XZAeUdjJFvPHp23La4s7afiM58I7eKBvrqPA7Cqxii
 070xz/dNmN0NOfnLkqyc9hnZ/mN9OhB+96+cIudlsrRzqr0ysmSqpuSEo7EYj9fmoODh
 C/USNY8vgKc5xtteWbzgJOjGRFGhWvr1CU11BPCY3+N/0ciwlCcOrpQOXYg5/e3zr7kX
 amCjlnkM6aQlnLbjgBloNAImjQuvajEG9I/8sUI+vXeHJZ9AUpfTWhzYKv/R6HL1pCDG
 DX+D/6V9z9kG4oxJqxC9nNC38nQHncFkMXwLdNg5c4k48VTqh1ynXaSUbM0qVMhsmw5s qw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s447kgbku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:03:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S63VvA003160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:03:32 GMT
Received: from [10.216.15.230] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 23:03:26 -0700
Message-ID: <01ef5a38-3902-6581-affa-eb68ba8b0d04@quicinc.com>
Date:   Fri, 28 Jul 2023 11:33:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] treewide: Update Guru Das Srinagesh's email address
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230728001622.4938-1-quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aVzKI4LprVvp0giywU_VJCpyoPPx5jij
X-Proofpoint-GUID: aVzKI4LprVvp0giywU_VJCpyoPPx5jij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=907
 clxscore=1011 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280054
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 5:46 AM, Guru Das Srinagesh wrote:
> Clean up my email address as the codeaurora.org address is not used
> anymore.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>   Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>   Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> index 2c8cf6aab19a..6b80518cbf62 100644
> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
>   
>   maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>   
>   description: |
>     Some Qualcomm PMICs have a "misc" module that can be used to detect when
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index e6a2387d8650..9e4eed34dae8 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Qualcomm Technologies, Inc. PM8008 PMIC
>   
>   maintainers:
> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>

Just a question, is this still needed after below change ?

https://lore.kernel.org/lkml/20230720210256.1296567-1-quic_bjorande@quicinc.com/

-Mukesh
>   
>   description: |
>     Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
