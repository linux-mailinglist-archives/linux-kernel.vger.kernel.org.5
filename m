Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA50791077
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351411AbjIDDmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjIDDmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:42:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A9FC5;
        Sun,  3 Sep 2023 20:42:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3842h4gH007357;
        Mon, 4 Sep 2023 03:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O+/XS3FO6CJQ1q+RWnw2Sk5jsuw5ukIgy+7tMylPBMg=;
 b=J1m75aG3z2Rz+VFjMCs/oUR8j5fW7DB9SPHANa1ZxLPSyZcTNCM3NsyDr88b8sKqG8W6
 7FGlsmKNq9MSNkZqSIuYRUixRId+N+t9mnJR5NEZKF88RelwygvRb1p+wAyxftYU6+xF
 /gkPLswI838fsOuelJU3WLXqGZNh0otCO1h5L87RilUPFLuOM+vuaEZPg6V1Hh/Rz1Bg
 YCU6nRp2DpWuK24kluFXFDJTrmoJV3MTp3Auk+me03P6fv3hoUXRleXH1M2YYZJ5nrzu
 u3wyxkLNj6LKgei37fYboXT45t3B7bJ7D+NiO70iVCiGtM2HYWNFAVp3nBJx5K4j939I mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvn6jfsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 03:42:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3843gTAW028984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 03:42:29 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 3 Sep
 2023 20:42:25 -0700
Message-ID: <dc7d8303-078d-4bd5-5e06-1e656f23d07a@quicinc.com>
Date:   Mon, 4 Sep 2023 09:12:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174
 family
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230901181041.1538999-1-robimarko@gmail.com>
 <28b7934f-f041-ad7b-d44a-3bed70aaf100@quicinc.com>
 <CAA8EJproMKoW=ue3dDCW88gkLyYqWQFvbmKdkoqXb3dVOL45dw@mail.gmail.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <CAA8EJproMKoW=ue3dDCW88gkLyYqWQFvbmKdkoqXb3dVOL45dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4FeLDyeKMif2HymWS17ddb_esjdhbkUF
X-Proofpoint-GUID: 4FeLDyeKMif2HymWS17ddb_esjdhbkUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_21,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=942 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040033
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/2023 9:05 PM, Dmitry Baryshkov wrote:
> On Sat, 2 Sept 2023 at 17:43, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>>
>> On 9/1/2023 11:40 PM, Robert Marko wrote:
>>> IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
>>> are missing so lets add them.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>    include/dt-bindings/arm/qcom,ids.h | 3 +++
>>>    1 file changed, 3 insertions(+)
>>
>> Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>
> Is there a chance of you using the full family name in your git tags?


Sure, Going forward will use the full family name..


Thanks,

>
>>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>>> index be12e1dd1f38..d2b84a308fde 100644
>>> --- a/include/dt-bindings/arm/qcom,ids.h
>>> +++ b/include/dt-bindings/arm/qcom,ids.h
>>> @@ -203,6 +203,9 @@
>>>    #define QCOM_ID_SM6125                      394
>>>    #define QCOM_ID_IPQ8070A            395
>>>    #define QCOM_ID_IPQ8071A            396
>>> +#define QCOM_ID_IPQ8172                      397
>>> +#define QCOM_ID_IPQ8173                      398
>>> +#define QCOM_ID_IPQ8174                      399
>>>    #define QCOM_ID_IPQ6018                     402
>>>    #define QCOM_ID_IPQ6028                     403
>>>    #define QCOM_ID_SDM429W                     416
>
>
