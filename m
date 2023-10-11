Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9317C55A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjJKNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjJKNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:40:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A490;
        Wed, 11 Oct 2023 06:40:44 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8VICM020844;
        Wed, 11 Oct 2023 13:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LFYz6xrKERqElDXusvARQZlN2k+C8ngHQ7mOc5rnUcs=;
 b=bgw2YLHAnygsRmPqqd/33LpZcPj2vP40i8xT1Bh71WWwdAkn59Z4LkZgmaKVn9UlmTGT
 pfhXso3/2onuvaiRU4drm3lsG9AKa5bK3/zOEctPm7A/h9r/Lo/Qr0Cm8JkusOPbm2tc
 /0tIC2XawAQ7Hng7Ib84Vusnbmy+eN+IFuWNP5OF1kUCuLZBVPHQSIhRs+NJGbLNBYHC
 mfNBlfzYAT4Q5gwaRfg2fFuyFiHqiEG4ImfUMu3UtEX9Nvl7QE3JFZy0eUcOdXTr2vy7
 jSxg/EP956V50WVusuNkx47f+5rU48OmyMSWLcrrXosCC3ZY6dhRJ/GTEA0/KM1hx1Gc aw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnnvw92qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:40:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BDecTi029877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:40:38 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 06:40:34 -0700
Message-ID: <442ac3d6-adcd-dbb7-96bb-de46023ec18e@quicinc.com>
Date:   Wed, 11 Oct 2023 19:10:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luca.weiss@fairphone.com>
References: <20231003175456.14774-1-quic_kbajaj@quicinc.com>
 <20231003175456.14774-3-quic_kbajaj@quicinc.com>
 <5da2ba4f-5bf7-46ff-8204-0c169042dbfa@linaro.org>
 <3fd31aaa-f6bf-8440-6b08-fca2803171d9@quicinc.com>
 <dba83334-3971-46e9-9342-1344c5858be8@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <dba83334-3971-46e9-9342-1344c5858be8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o8jlPon2RgY8RHo6AB-XrKo9954iFvIL
X-Proofpoint-GUID: o8jlPon2RgY8RHo6AB-XrKo9954iFvIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110120
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 3:17 PM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 07:40, Mukesh Ojha wrote:
>>
>>
>> On 10/7/2023 5:02 AM, Konrad Dybcio wrote:
>>> On 3.10.2023 19:54, Komal Bajaj wrote:
>>>> Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
>>>> platform. QCM6490 is derived from SC7280 meant for various
>>>> form factor including IoT.
>>>>
>>>> Supported features are, as of now:
>>>> * Debug UART
>>>> * eMMC
>>>> * USB
>>>>
>>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>>> ---
>>> [...]
>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490.dtsi 
>>>> b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>>> new file mode 100644
>>>> index 000000000000..b93270cae9ae
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>>> @@ -0,0 +1,94 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>>> reserved.
>>>> + */
>>>> +
>>>> +#include "sc7280.dtsi"
>>>> +
>>>> +/*
>>>> + * Delete unused sc7280 memory nodes and define the memory regions
>>>> + * required by qcm6490
>>>> + */
>>>> +/delete-node/ &rmtfs_mem;
>>>> +/delete-node/ &wlan_ce_mem;
>>>> +
>>>> +/{
>>>> +    reserved-memory {
>>>> +        cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
>>>> +            reg = <0x0 0x81800000 0x0 0x1e00000>;
>>>> +            no-map;
>>>> +        };
>>>> +
>>>> +        camera_mem: camera@84300000 {
>>> Uhh.. this is totally not the same memory map that I have on a
>>> random msm-5.4 source+devicetree drop (which does in turn align
>>> with the one on QCM6490 Fairphone 5, as it should because it's
>>> a rebadged reference device for the most part)..
>>>
>>> Did you guys *really* redo it between software releases?
>>
>> QCM6490 fairphone is special case where same SOC is used for mobile
>> product and it uses sc7280 memory map.
>>
>> Current patch adds support for the same SOC marketed for IOT segment
>> [1] and very active in the development and soon going to freeze its
>> memory map, so we are deriving memory map from sc7280 and creating
>> a new memory map for all IOT product with qcm6490.dtsi .
> Stop reinventing the wheel. I'm not going to accept patches that are 
> supposed to define ABI for products that are still in development.
> Not unless Qualcomm changes their attitude towards unilaterally breaking 
> things for no good reason.
> 
>>
>> [1]
>> https://www.qualcomm.com/products/internet-of-things/industrial/building-enterprise/qcm6490
>>
>>>
>>> This SoC family has been on the market for quite some time,
>>> breaking software expectations like that is not cool, especially
>>> on a product with a promised lifespan of 10 years or whatever!
>>
>> I agree, but we are not changing anything for product which are there
>> in the market instead defining a new memory map what is going to come
>> with qcm6490.dtsi for IOT.
> Why would the OS care about the market segment you're targeting?
> Why would the firmware you're building care about the market segment 
> you're targeting? The LE vs LA vs LU vs WP vs whatever split is so 
> unnecessary and arbitrary on the firmware/kernel side..

Forgive me, if i ask some very basic question, just trying to put my
thought,

I agree, OS should not worry about the market segment, but through the
DT firmware, we can better optimize memory to either give more memory to
user or give more memory to certain DSP's to enable certain feature 
through the firmware like some logging infra etc., and due to which
certain gaps can get created where certain memory region need to be
move up or down due to increase in the carve-out.

Let's say X Soc released with some memory map, any derivative SoC Y
should follow X's memory map if it is including X dtsi ? and the reason 
why Y want to include X is solely the work done for X and most of 
peripheral memory addresses is matching.

But 'Y' could be different product, right? and it could have different
firmware and it is not like 'X' firmware will run on 'Y' ?

Now a days, most of our firmware are relocatable.

-Mukesh
> 
> The firmware should either be fully relocatable (so that dynamic memory 
> reservation can be used), unified so that there's no changes or better 
> yet stored in separate memory so that q6 cores don't steal the RAM that 
> the user paid for and you can do whatever ugly magic you please in there.
> 
> This arbitrary segmentation makes it impossible to have a common base, 
> or to explain what device should go where to a newcomer.
> 
> Sorry, the other qcm6490 soc with
>> fairphone(for mobile) can get confuse with qcm6490.dtsi but that
>> is special case and i hope, that should be fine but, let me know if
>> there is concern.
>>>
>>> With that, this really seems more of a change that would belong
>>> in the IDP dts than the 6490-common one..
>>
>>
>> We wanted to keep it in qcm6490.dtsi as there are some more product
>> going to share this in future.
> And then what if you decide that you need to re-release SC7280 for 
> automotive and make changes again? Do we define qcm6490au.dtsi which 
> will redefine everything again-again?
> 
> Konrad
