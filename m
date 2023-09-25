Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB007AD0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjIYGvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjIYGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:51:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761D127;
        Sun, 24 Sep 2023 23:51:03 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38OLgXgE009642;
        Mon, 25 Sep 2023 08:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=tvHsmyNb1PnnYdO5pOCgniGzhWXe2yU/9kcC7imykWM=; b=ER
        ye3s8UNuBYUzblAwoRhav8Qpy4NM0fUA1zZuSnAEIpJx8uABo/czF4DBJnQS1kSR
        64gK5VYLW5D2PrjgUDWt7lGlNkUUanPMGbgC3UEpizCTkavo6+QTIYKkxnlp3hft
        HLAF7OYA3/GF1bP6vRx6ETVaxdYBnUPhk9KEj54x0U7sH6LnBba4ABgS0/vxTqyL
        0iJNdu8CKZMgMwUAjV+hnrZCtzYUU4zA69PI1HuI+msAkXclHEf0ntF7b76rdB10
        n/SxZEbumtIpy18bOe7gkz+5jhAIjvOpBTizIB/b2TFKPaZEBjbOFrwDMeDulxRi
        zl9UTkBdwZXrSh3v7zKA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ta9k03gqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 08:50:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6E9710005C;
        Mon, 25 Sep 2023 08:50:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC5DF21514C;
        Mon, 25 Sep 2023 08:50:40 +0200 (CEST)
Received: from [10.252.7.228] (10.252.7.228) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 08:50:40 +0200
Message-ID: <b02d3983-c238-f79f-0edc-dd0db305b697@foss.st.com>
Date:   Mon, 25 Sep 2023 08:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/4] ARM: dts: st: stih407: drop max-duty-cycle
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
 <20230730174954.5293-4-krzysztof.kozlowski@linaro.org>
 <e6afc5bb-7477-36d6-b05b-2afdd1107f03@foss.st.com>
 <a004afcd-08a0-4da4-9e3c-3b12445c7b43@linaro.org>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <a004afcd-08a0-4da4-9e3c-3b12445c7b43@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.7.228]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/23 20:53, Krzysztof Kozlowski wrote:
> On 16/08/2023 08:54, Patrice CHOTARD wrote:
>>
>>
>> On 7/30/23 19:49, Krzysztof Kozlowski wrote:
>>> "max-duty-cycle" property was removed in the commit f747a1fe7848
>>> ("regulator: pwm-regulator: Remove obsoleted property"):
>>>
>>>   stih418-b2199.dtb: pwm-regulator: Unevaluated properties are not allowed ('max-duty-cycle' was unexpected)
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> 1. Correct subject prefix: AMR->ARM
>>> ---
>>>  arch/arm/boot/dts/st/stih407-family.dtsi | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
>>> index 3f58383a7b59..29302e74aa1d 100644
>>> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
>>> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
>>> @@ -111,7 +111,6 @@ pwm_regulator: pwm-regulator {
>>>  		regulator-min-microvolt = <784000>;
>>>  		regulator-max-microvolt = <1299000>;
>>>  		regulator-always-on;
>>> -		max-duty-cycle = <255>;
>>>  		status = "okay";
>>>  	};
>>>  
>>
>>
>> Applied on sti-next
> 
> This is still not in linux-next (one month later!).

Hi Krzysztof

Yes i saw that, i submitted my pull request to ML but it hasn't be merged.
I just notice i forgot to add soc@kernel.org in the sender list, my bad :-(
I expect to resubmit it for v6.7.

Patrice

> 
> I don't know what happened here, maybe patch got lost (thus let me know
> if I am expect to apply it, which should not be the norm, but meh...).
> If it is not the case and for example your tree is not in next, then
> maybe this will be of use:
> https://social.kernel.org/notice/Aa2Gbxj4cyyuUb0P8S
> https://lpc.events/event/17/contributions/1498/
> 
> :)
> 
> Best regards,
> Krzysztof
> 
