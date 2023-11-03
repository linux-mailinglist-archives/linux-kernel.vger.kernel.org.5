Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DBE7E00FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjKCILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjKCILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:11:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29701A8;
        Fri,  3 Nov 2023 01:11:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A359R76014714;
        Fri, 3 Nov 2023 08:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u3JwXlcRcYPnxvK4HEmxg7Tn23cs0JQWAl1lXbwAKV0=;
 b=C2ssioIo2o3NeAxVbkPngBn48yRuC9fY5RUWjUHzkmB/RKMa1uv1MpH6/G9kCM9p3GSv
 GVeMaHq9RuAUzlAFddNsBKDEXBELfYHdc34Kbtln/z+3xg8lAJ4FXxNYrP65j9C+Ujd8
 KAR245B0IDRgbBLOe8yPmeshctzMT9e0omuMKrQwl2vEy5dZqHnkS7SEySHgziXPDDoZ
 90p8K+zM4Ld4NlJpNZA4YRrO1qdkwy1f028gIbKEb/aS8a+3uyh9umJslu7dsryXReeO
 X5nb0yiNhL09p01FFDeNWWDWaa+zprCJTm5hOspS5kdyKYGVP7R3MqqqWGP+y//eN540 lA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u477ptpat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 08:11:34 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A38BX1o006588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 08:11:33 GMT
Received: from [10.216.16.147] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 01:11:27 -0700
Message-ID: <b6a023e9-bb54-44d6-8a48-5f6204da5b95@quicinc.com>
Date:   Fri, 3 Nov 2023 13:41:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
CC:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-5-srichara@win-platform-upstream01.qualcomm.com>
 <1c6ecc92-89d3-3b7e-c2d0-e2fded9b446d@gmail.com>
 <f44b6e59-c26e-1026-49b7-e02ff02d7562@quicinc.com>
 <CAOX2RU6j75+8tFMTu=fVKY=mBkv8OaZJzWYUfnqkwfJY01QqYw@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAOX2RU6j75+8tFMTu=fVKY=mBkv8OaZJzWYUfnqkwfJY01QqYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dJiFYVTVgberLcXSF2KIYI7ivCo-g49y
X-Proofpoint-ORIG-GUID: dJiFYVTVgberLcXSF2KIYI7ivCo-g49y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_06,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030066
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<..>

>>> On 22. 09. 2023. 13:51, Sricharan R wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>>>> There is no RPM, so tsens has to be manually enabled. Adding the tsens
>>>> and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
>>>> critical temperature being 120'C and action is to reboot. Adding all
>>>> the 4 zones here.
>>>>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> ---
>>>>    [v3] Ordered the qfprom device node properties as per
>>>>         Krzysztof's comments
>>>>
>>>>    arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
>>>>    1 file changed, 169 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> index 9f13d2dcdfd5..9e28b54ebcbd 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>> @@ -93,6 +93,117 @@ soc: soc@0 {
>>>>            #size-cells = <1>;
>>>>            ranges = <0 0 0 0xffffffff>;
>>>> +        qfprom: qfprom@a0000 {
>>>> +            compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
>>> Hi,
>>>
>>> "qcom,ipq5018-qfprom" needs to be documented in QFPROM bindings first.
>>
>>    Already posted here [1]. Initially had it in the same series, but kept
>>    it separately based on review comments.
>>
>>    [1] https://www.spinics.net/lists/devicetree/msg633408.html
> 
> Well, if it's not part of the same series then this addition would
> cause a warning as its
> undocumented.
> 
> I also dont see where is it documented as part of the v2 series.

  Then in that case, will keep it in same series again in V4

Regards,
  Sricharan
