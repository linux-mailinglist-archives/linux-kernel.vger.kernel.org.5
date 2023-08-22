Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC77839F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjHVGad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjHVGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:30:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A6E9;
        Mon, 21 Aug 2023 23:30:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M5U223016523;
        Tue, 22 Aug 2023 06:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vr1z7gz3lr9nrRVrsJFledqkkN5bVdsul360cc1b/D4=;
 b=VR5HvpCf76cENcjS8TqJha3Ymb7TJ1UcpjpPxShggRcC8i0RZR8rLkCFOlzo/uqe2u9n
 BiWFdURJ8+bqQ+Zn4Nv4tz3casKNfXWS80814Xgd+T9w/c0jMmwg9JYdxoA+EwkLkdRv
 6hpFRYQvGVlVLYx6JWuJOJjSJk0QCLYuq57W1V+ZhbZ+w3xEAVuHdQsuVsjvXOFiodUl
 VjU3hc78GEpktG45IH0V11+DE5/oAX1E7STnEQPaFJnZqDcN3ypdbwf8cbYGXMCXwe9b
 UiJPAdGacjlGk4mznl8R0m3I3o2Y6ZorIc1KiKnNT0VbzS3ZSE8VK+vHhJjD1YXe6mzq Tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm3xvapee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:30:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M6UFgf027906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:30:15 GMT
Received: from [10.214.27.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 23:30:12 -0700
Message-ID: <85599f80-8c10-d373-c27c-b3d91ad1f273@quicinc.com>
Date:   Tue, 22 Aug 2023 12:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add the rpmhpd header
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690781104-2290-4-git-send-email-quic_rohiagar@quicinc.com>
 <20230821151123.GA1607676-robh@kernel.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20230821151123.GA1607676-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bu4VDdVybaTAAnrnNTPLHbRVJdqo3mN-
X-Proofpoint-ORIG-GUID: bu4VDdVybaTAAnrnNTPLHbRVJdqo3mN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_05,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=850 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220052
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/21/2023 8:41 PM, Rob Herring wrote:
> On Mon, Jul 31, 2023 at 10:55:03AM +0530, Rohit Agarwal wrote:
>> Add the rpmhpd header having the definition of the regulator levels
>> for Qualcomm SoCs.
> Why? (Commit msgs should answer that question)
Ok, Will add more details.

Thanks,
Rohit.
>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 1 +
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi  | 1 +
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sc8180x.dtsi  | 1 +
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>>   arch/arm64/boot/dts/qcom/sdm670.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sm6350.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi   | 1 +
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi   | 1 -
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi   | 1 -
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi   | 1 -
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi   | 1 -
>>   14 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 1c0e5d2..2210447 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index b130136..a17dffdb 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -11,6 +11,7 @@
>>   #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index e25dc2b..ed77e04 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -16,6 +16,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index a0e8db8..e35a73e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -19,6 +19,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
>> index d3ae185..8482437 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/interconnect/qcom,sc8180x.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index ac0596d..a579716 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -15,6 +15,7 @@
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/sound/qcom,q6afe.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> index a1c207c..898831c 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> @@ -14,6 +14,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 02a6ea0..0156460 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -20,6 +20,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,apr.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> index 30e7701..46b3ea5 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> @@ -16,6 +16,7 @@
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index 18c822a..dc75d28 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -7,6 +7,7 @@
>>   #include <dt-bindings/dma/qcom-gpi.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 22bf99c..fe04d25 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -15,7 +15,6 @@
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   #include <dt-bindings/interconnect/qcom,sm8250.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>> -#include <dt-bindings/power/qcom-rpmpd.h>
> Doesn't match the patch description.
>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,apr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index edc072e..07779c6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -14,7 +14,6 @@
>>   #include <dt-bindings/interconnect/qcom,sm8350.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>> -#include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 6bd6a6c..3f86b2c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -13,7 +13,6 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>>   #include <dt-bindings/phy/phy-qcom-qmp.h>
>> -#include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/interconnect/qcom,sm8450.h>
>>   #include <dt-bindings/soc/qcom,gpr.h>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index 59bd1c7..c316ba8 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -14,7 +14,6 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
>>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>> -#include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> -- 
>> 2.7.4
>>
