Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238377C879A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjJMOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjJMOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:14:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44EDBD;
        Fri, 13 Oct 2023 07:14:39 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDafom023858;
        Fri, 13 Oct 2023 14:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=grR8FYt+Riiv30XQgqDuu7wWSPJLLadw4Icnz+HoV3s=;
 b=RaW8sDCY6/sQGD9Od+D4DINHUHyU6oA5CNzKfr0mR+30zoBkoOK6Vz2maDlA3y0ZhcVL
 otSSKDptQX4swgrTMkD5oKUAvV8lguZTqZDWogBOg1DUh34IbBQfW70uJpvw8I3NDFge
 tr7I9SwPeeZgMk5/HcvVnAg9dQe3/B6f40JIGP1hS7j8uLLRjuV07EVzrPEAhvJMwsf3
 W49naYgUo0e6KCk2NQ+79rTUYHY5reSNFRl4OG2k7tXYPLMzL5Gjh+FP7zmrZbdB3a4w
 oBEmqugOsS/v3VFicLIQsTSDqN22Rth1G+VzBnpV7/lhlv2i1aNZxqlf4FpvVbZbEdL+ Cg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt10hv1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:14:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DEE5ma032360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:14:05 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 07:14:01 -0700
Message-ID: <d97ebf74-ad03-86d6-b826-b57be209b9e2@quicinc.com>
Date:   Fri, 13 Oct 2023 19:43:49 +0530
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
 <442ac3d6-adcd-dbb7-96bb-de46023ec18e@quicinc.com>
 <8ee2f72b-fcf4-4278-97b4-906046b40c6b@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <8ee2f72b-fcf4-4278-97b4-906046b40c6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fWeGpeMA3PtCJVbyuv0RbE7lzOjcvbGw
X-Proofpoint-ORIG-GUID: fWeGpeMA3PtCJVbyuv0RbE7lzOjcvbGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130120
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 4:25 AM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 15:40, Mukesh Ojha wrote:
>>
>>
>> On 10/11/2023 3:17 PM, Konrad Dybcio wrote:
>>>
>>>
>>> On 10/11/23 07:40, Mukesh Ojha wrote:
>>>>
>>>>
>>>> On 10/7/2023 5:02 AM, Konrad Dybcio wrote:
>>>>> On 3.10.2023 19:54, Komal Bajaj wrote:
>>>>>> Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
>>>>>> platform. QCM6490 is derived from SC7280 meant for various
>>>>>> form factor including IoT.
>>>>>>
>>>>>> Supported features are, as of now:
>>>>>> * Debug UART
>>>>>> * eMMC
>>>>>> * USB
>>>>>>
>>>>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>>>>> ---
>>>>> [...]
>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490.dtsi 
>>>>>> b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>>>>> new file mode 100644
>>>>>> index 000000000000..b93270cae9ae
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>>>>> @@ -0,0 +1,94 @@
>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>> +/*
>>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>>>>> reserved.
>>>>>> + */
>>>>>> +
>>>>>> +#include "sc7280.dtsi"
>>>>>> +
>>>>>> +/*
>>>>>> + * Delete unused sc7280 memory nodes and define the memory regions
>>>>>> + * required by qcm6490
>>>>>> + */
>>>>>> +/delete-node/ &rmtfs_mem;
>>>>>> +/delete-node/ &wlan_ce_mem;
>>>>>> +
>>>>>> +/{
>>>>>> +    reserved-memory {
>>>>>> +        cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
>>>>>> +            reg = <0x0 0x81800000 0x0 0x1e00000>;
>>>>>> +            no-map;
>>>>>> +        };
>>>>>> +
>>>>>> +        camera_mem: camera@84300000 {
>>>>> Uhh.. this is totally not the same memory map that I have on a
>>>>> random msm-5.4 source+devicetree drop (which does in turn align
>>>>> with the one on QCM6490 Fairphone 5, as it should because it's
>>>>> a rebadged reference device for the most part)..
>>>>>
>>>>> Did you guys *really* redo it between software releases?
>>>>
>>>> QCM6490 fairphone is special case where same SOC is used for mobile
>>>> product and it uses sc7280 memory map.
>>>>
>>>> Current patch adds support for the same SOC marketed for IOT segment
>>>> [1] and very active in the development and soon going to freeze its
>>>> memory map, so we are deriving memory map from sc7280 and creating
>>>> a new memory map for all IOT product with qcm6490.dtsi .
>>> Stop reinventing the wheel. I'm not going to accept patches that are 
>>> supposed to define ABI for products that are still in development.
>>> Not unless Qualcomm changes their attitude towards unilaterally 
>>> breaking things for no good reason.
>>>
>>>>
>>>> [1]
>>>> https://www.qualcomm.com/products/internet-of-things/industrial/building-enterprise/qcm6490
>>>>
>>>>>
>>>>> This SoC family has been on the market for quite some time,
>>>>> breaking software expectations like that is not cool, especially
>>>>> on a product with a promised lifespan of 10 years or whatever!
>>>>
>>>> I agree, but we are not changing anything for product which are there
>>>> in the market instead defining a new memory map what is going to come
>>>> with qcm6490.dtsi for IOT.
>>> Why would the OS care about the market segment you're targeting?
>>> Why would the firmware you're building care about the market segment 
>>> you're targeting? The LE vs LA vs LU vs WP vs whatever split is so 
>>> unnecessary and arbitrary on the firmware/kernel side..
> First of all, I vented off on you very heavily in response to seeing 
> something I don't like, even though you didn't have anything to do with 
> it. Please accept my apology.

That's fine, Np..

> 
> There are some difficulties with integrating certain things upstream to 
> work out on a broader scale, but me screaming at engineers in public 
> won't help much with that.
> 
>> Forgive me, if i ask some very basic question, just trying to put my
>> thought,
>>
>> I agree, OS should not worry about the market segment, but through the
>> DT firmware, we can better optimize memory to either give more memory to
>> user or give more memory to certain DSP's to enable certain feature 
>> through the firmware like some logging infra etc., and due to which
>> certain gaps can get created where certain memory region need to be
>> move up or down due to increase in the carve-out.
> This is totally fine from a generic standpoint, however Qualcomm has a 
> history (and you can see that in most SoC DTSIs) of having a common (or 
> almost common) memory map on the vast majority of devices based on a 
> given family of SoCs. We've been steadily taking advantage of that for 
> quite some time.
> 
> Here, we have an established compute SoC (7280-Chrome) with a memory 
> setup that roughly matches its mobile counterpart (6490-LA or 778G or 
> whatever different derivatives).

I understand..

> 
> IIUC you're tweaking the software for the "new IoT BSP" and resizing 
> some regions resulted in many differences (as PIL regions tend to be 
> contiguous one-to-another).

This is correct. There are some other differences like cdsp/adsp support 
that we shall be pushing soon which sc7280 doesn't use.

> The real issue here is that if we express 
> this changed memory map in qcm6490.dtsi, all devices that have already 
> shipped with the older-than-"new IoT BSP" software will differ rather 
> significantly.

Yes, I see your point. Subjective to this product segment there may be 
other BSP related additions.

> You mentioned that there are going to be multiple users of *this new* 
> configuration, perhaps qcm6490-iot-common.dtsi (similar to 
> sc7280-chrome-common.dtsi) could facilitate the new bsp changes instead, 
> making it less ambiguous.

Yeah, so IIUC to avoid any ambiguity (like mentioned in your previous 
comment) this might be a better option.

>>
>> Let's say X Soc released with some memory map, any derivative SoC Y
>> should follow X's memory map if it is including X dtsi ? and the 
>> reason why Y want to include X is solely the work done for X and most 
>> of peripheral memory addresses is matching.
>>
>> But 'Y' could be different product, right? and it could have different
>> firmware and it is not like 'X' firmware will run on 'Y' ?
> Right, historically that hasn't happened very often but it could be like 
> that.

This is what we are looking for..

> 
>> Now a days, most of our firmware are relocatable.
> And we should totally take advantage of that. Stephan Gerhold has 
> submitted some improvements that made it possible to dynamically 
> allocate memory regions on 8916, this should probably be reused and 
> expanded for other SoCs.  Would it be possible for you to try out 
> dynamic PIL region allocation on this board? See [1] for example.

You mean adapting this qcm6490.dtsi change to dynamic region? Can we do 
that without touching sc7280.dtsi memory map itself.

> And the last thing is, I would like for you to give us some sort of a 
> stability promise for this. You mentioned this SoC spin is "very active 
> in the development", which makes me worried for DT compatibility with 
> future METAs. We have unfortunately historically had to deal with 
> different firmware packages behaving in divergent ways, and not always 
> consistently between devices (but the last point may be just vendor 
> modifications).

We are checking and will come back on this. Outside these BSP dependent 
things, don't see a challenge in maintaining SoC support compatibility.

> We are supposed to be able to boot any future version of Linux with this 
> initial devicetree, unless there's some fatal flaw that needs 
> retroactive fixing (like when we tried to express LLCC as a contiguous 
> region instead of a set of slices up until 8550 release or so). Please 
> have that in mind, we've tried so hard to keep this ABI-like.

Yes, the plan is to maintain this SoC on moving latest kernel tips.

> And the last-last (I promise..) question, is this the final SoC silicon 
> revision? And is it any different from the QCM6490 that has landed in 
> some Android devices physically? Or does it simply ship with a different 
> sw stack?

I am not aware of this. In case the SoC is revised then the support need 
to be extended for new revision as well maintaining compatibility for 
older one.

-Mukesh

> 
> Konrad
> 
> [1] 
> https://lore.kernel.org/linux-arm-msm/20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net/#t
