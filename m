Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192879084B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjIBOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIBOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:43:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A010EB;
        Sat,  2 Sep 2023 07:43:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 382EUhmH016693;
        Sat, 2 Sep 2023 14:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7IgLdeYroN9h8kUtLquNCkhdvV1TsayyKIMA2uBI1KI=;
 b=infarNO153jGlQupJPgQuVkA1MOyiCcaCYMgnYHURV9AYjV3NmkUrM1XsVeqFcnnTh8R
 m3w7CwJ3Kgxg6WucRzjK9L33HS8UbYzpe0F7I4H0bEWXSqcT8YNLlVHSTx1D/1Is9XBf
 gX/JgXC5Xgui2UC2kAJpp0ffjrmgAnbckINkn5hDenoam7X54sI3ZSKFDT/JBDiyo89p
 8koUjUFF6OtBqsvgJQewl57ZJwuNa1uGmkQeqrNlpMx5yfWI6oYDb8ZPZCO4XjOUL+cX
 XzTyfc8fpbzgjy9nJkAIaeda3LF2LWHp+G3gcfaCt0v3cRXSAltaGWLVsG/Kl7zL8CJx 1A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcr8nrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Sep 2023 14:43:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 382EhJ9a008178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 2 Sep 2023 14:43:19 GMT
Received: from [10.216.50.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 2 Sep
 2023 07:43:12 -0700
Message-ID: <28b7934f-f041-ad7b-d44a-3bed70aaf100@quicinc.com>
Date:   Sat, 2 Sep 2023 20:12:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174
 family
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230901181041.1538999-1-robimarko@gmail.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230901181041.1538999-1-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v91YVXAMLEqM4C0XzDp10JK0U7NqvPcr
X-Proofpoint-ORIG-GUID: v91YVXAMLEqM4C0XzDp10JK0U7NqvPcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-02_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=821 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309020137
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2023 11:40 PM, Robert Marko wrote:
> IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
> are missing so lets add them.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   include/dt-bindings/arm/qcom,ids.h | 3 +++
>   1 file changed, 3 insertions(+)


Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>


>
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index be12e1dd1f38..d2b84a308fde 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -203,6 +203,9 @@
>   #define QCOM_ID_SM6125			394
>   #define QCOM_ID_IPQ8070A		395
>   #define QCOM_ID_IPQ8071A		396
> +#define QCOM_ID_IPQ8172			397
> +#define QCOM_ID_IPQ8173			398
> +#define QCOM_ID_IPQ8174			399
>   #define QCOM_ID_IPQ6018			402
>   #define QCOM_ID_IPQ6028			403
>   #define QCOM_ID_SDM429W			416
