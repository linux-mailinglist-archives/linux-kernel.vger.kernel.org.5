Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF1768F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjGaIC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGaIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:01:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E710F0;
        Mon, 31 Jul 2023 01:01:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V69ec5023307;
        Mon, 31 Jul 2023 07:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NQmFd9voUPRvPY48qtiUCgPcaqPB+4mxUGECcZrKvNA=;
 b=gA9KBjBxU7Mngyvq9BvCIfFaoxBE6EB7AF1iEMxkRo2Gzh1Ypditnn9r+ik27yF8GUHS
 gOt3qMT7qVRN4GdrlVrBBqpq7NwIED9oFdVxH3Ocle3yBABTRotY5SFsd421SNWw+HPd
 oDyi/DZ/UNZmkWoPXUpkWAtgR7xJRdz2zjntgJHItIpxyCFyva67kFWcEKHhrQKUmgGQ
 ZBszVx8DbL6ERVgBlUhzy5VpVKoAGGlm2xnEqQISwUKf8nWs4oUvjWYe43Wm+KVdFoCN
 XYxoM+c9prtlMewHWSZO9bfaI6SZsqmLBoJ4gYLSeFYVp/Ew7bcm7A5VjmpuOHuJvKzC DQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4urxau7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:22:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V7M0oX005457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:22:00 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 00:21:56 -0700
Message-ID: <53132580-53b6-06bc-8b48-51a3f56ab71d@quicinc.com>
Date:   Mon, 31 Jul 2023 15:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] dt-bindings: arm: qcom,ids: Adjust the position of
 QCOM_ID_QDU1010
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731061325.26431-1-quic_tengfan@quicinc.com>
 <20230731061325.26431-6-quic_tengfan@quicinc.com>
 <981a79ee-5258-eb76-020a-765f5f39866f@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <981a79ee-5258-eb76-020a-765f5f39866f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mWVzMPqibV4icecYAuxGdXJlpkFFO9S2
X-Proofpoint-ORIG-GUID: mWVzMPqibV4icecYAuxGdXJlpkFFO9S2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=606
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/31/2023 3:00 PM, Krzysztof Kozlowski 写道:
> On 31/07/2023 08:13, Tengfei Fan wrote:
>> Adjust the position of QCOM_ID_QDU1010, so that there is a coherent
>> sequence of numbers.
>>
>> Change-Id: Id083e1ecc92c063c1a07a81c66dcb034020964b0
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
sure, will do this check if this patch still need.
>> ---
>>   include/dt-bindings/arm/qcom,ids.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> index bcbe9ee2cdaf..977c235ed0d9 100644
>> --- a/include/dt-bindings/arm/qcom,ids.h
>> +++ b/include/dt-bindings/arm/qcom,ids.h
>> @@ -249,8 +249,8 @@
>>   #define QCOM_ID_SA8775P			534
>>   #define QCOM_ID_QRU1000			539
>>   #define QCOM_ID_QDU1000			545
>> -#define QCOM_ID_QDU1010			587
>>   #define QCOM_ID_IPQ5019			569
> 
> I don't think this change is needed. Isn't IPQ5019 going away?
Will remove this patch, another is handling this: 
https://lore.kernel.org/lkml/20230724083745.1015321-1-quic_kathirav@quicinc.com/T/
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
