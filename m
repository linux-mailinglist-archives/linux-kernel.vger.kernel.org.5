Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E275AC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGTLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGTLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:05:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FB268F;
        Thu, 20 Jul 2023 04:05:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KASIVh004024;
        Thu, 20 Jul 2023 11:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t/rC43SaN1aFaJyVR8FzDXCtjGfiom/DgT6LMZXPph8=;
 b=QU8OBGYea6vjQaVX5qfOnn9BZdz/IYR+AZ7JiZ7gstU+2N37jDiJ8OR9aUY8ww3NyDme
 J/XtnGult5YdMBOTmJQ+dM+OXw7nRJEHo1eFef6R+kNN4yUxqnUE6/7+Wh7S3xZ3g8RW
 iZpwxhoFo8CH4jt4QJFxWCbJOVNVH0gX9oGicLf1lq5qLt8Ykca1cIXFIis5eOMoybet
 BxVR4ZPzOhWLWJ/MVAUxWDxNc7zBdc4YuPrRyw1vjFMl3Yg/oYTHgNK2zHcO26yWXDt/
 bNagcb2RLsj0wPHkSPhCFnPj8YhGQYdYLd2dqEi/FK9UouV4ai6veUWVqyrRiHHOjfTO Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxummrx6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:05:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KB50nG027242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:05:00 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:04:56 -0700
Message-ID: <a826aaa8-d800-921a-f00e-7929946d9a63@quicinc.com>
Date:   Thu, 20 Jul 2023 16:34:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Update the compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720072938.31546-1-quic_harihk@quicinc.com>
 <20230720072938.31546-2-quic_harihk@quicinc.com>
 <9283b320-5d77-350c-5312-90d56dfb922f@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <9283b320-5d77-350c-5312-90d56dfb922f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gogel7oGAV50McmIsofbdRU4r4rgRY2f
X-Proofpoint-GUID: gogel7oGAV50McmIsofbdRU4r4rgRY2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=961
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200092
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 2:12 PM, Krzysztof Kozlowski wrote:
> On 20/07/2023 09:29, Hariharan K wrote:
>> Update the compatible in device tree binding to
>> use model names instead of rdp numbers for IPQ5018
>> platform.
>>
>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index e94ce1e26fbf..922feb912594 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -97,6 +97,7 @@ description: |
>>           ap-mi01.3
>>           ap-mi01.6
>>           ap-mi01.9
>> +        ap-mp03.5-c2
>>           cdp
>>           cp01-c1
>>           dragonboard
>> @@ -105,7 +106,6 @@ description: |
>>           hk10-c2
>>           idp
>>           liquid
>> -        rdp432-c2
>>           mtp
>>           qrd
>>           rb2
>> @@ -343,7 +343,7 @@ properties:
>>   
>>         - items:
>>             - enum:
>> -              - qcom,ipq5018-rdp432-c2
> 
> 
> There is no such compatible. Don't send patches with wrong names and
> before they got merged send a follow up.
> 
> Fix the original submission.

Sorry, this patch is in-correct. Names used in the original submission 
are the right ones. Will drop this patch and also fix it in other 
patches that i have posted.

Best regards,
Hariharan K

> 
> Best regards,
> Krzysztof
> 

