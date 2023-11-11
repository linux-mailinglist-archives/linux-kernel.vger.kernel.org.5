Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4027E8B72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjKKQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:05:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AF3A81;
        Sat, 11 Nov 2023 08:05:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D42C433C7;
        Sat, 11 Nov 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699718727;
        bh=kUjdXhm4XIHaSixq3RfNZfAa33jeURgyW2Gi0Awq3zk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mz7gkbabkfJXFO/abvyaZ1DQy3HE+JSCpyB4OStXLwfPUKlsQFlD0K+zpw0ss2ny4
         HvwK+up8YPCyuQUuWGgu1OtCI6LQxm0HqPib1/NRwaCpt7PfhR88MwlcWaXh9Szeue
         XHZDUKzaxcukMM93+v5ErGd8wA78BwO/EQY4zCUsYn7+sw9Pp4NB+Z9UBUhzTVo/hQ
         pyda8l11HiCKVMOmJtQLbGAXZ553vMV3oIi0NdF+Gwk55HsURwJ4WOOc2MkOiV2Vpi
         Zw1DpxKjo9Cd7qc1btBiF7k6g4n3zFHkH9u8U+PQaMnYaelcELnsLwv2sfu+RbVeyR
         wWutiLA6+0LCw==
Message-ID: <01c7c200-f5ec-415f-9342-7838fe0862ba@kernel.org>
Date:   Sat, 11 Nov 2023 18:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
To:     "Anwar, Md Danish" <a0501179@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>, netdev@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com, nm@ti.com, srk@ti.com,
        Md Danish Anwar <danishanwar@ti.com>
References: <20231110084227.2616-1-r-gunasekaran@ti.com>
 <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
 <44f68604-b37d-56d9-6fc1-4c4cc503abd3@ti.com>
 <e96bd133-7bc7-b2ae-4d70-69f2ad5c9aff@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <e96bd133-7bc7-b2ae-4d70-69f2ad5c9aff@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 18:21, Anwar, Md Danish wrote:
> On 11/10/2023 3:08 PM, Ravi Gunasekaran wrote:
>> Roger,
>>
>> On 11/10/23 2:21 PM, Roger Quadros wrote:
>>> Hi Ravi,
>>>
>>> On 10/11/2023 10:42, Ravi Gunasekaran wrote:
>>>> Grygorii is no longer associated with TI and messages addressed to
>>>> him bounce.
>>>>
>>>> Add Siddharth and myself as reviewers.
>>>>
>>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>> ---
>>>>  MAINTAINERS | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 7b151710e8c5..bd52c33bca02 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>>  F:	drivers/counter/ti-eqep.c
>>>>  
>>>>  TI ETHERNET SWITCH DRIVER (CPSW)
>>>> -R:	Grygorii Strashko <grygorii.strashko@ti.com>
>>>> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> +R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>
>>> Could you please add me as Reviewer as well. Thanks!
>>
>> Thanks for volunteering to be a reviewer.
>>
>> I posted a v2 adding you as a reviewer.
>> https://lore.kernel.org/all/20231110092749.3618-1-r-gunasekaran@ti.com/
>>
>>>
>>>>  L:	linux-omap@vger.kernel.org
>>>>  L:	netdev@vger.kernel.org
>>>>  S:	Maintained
>>>
>>>> F:      drivers/net/ethernet/ti/cpsw*
>>>> F:      drivers/net/ethernet/ti/davinci*
>>>
>>> What about am65-cpsw*?
>>>
>>> And drivers/net/ethernet/ti/icssg/*
>>
>> I would prefer a separate entry for ICSSG. Will let Danish comment on this.
>>
> 
> Sure, I will share a separate patch for this. Roger, do you want me to
> add you as a reviewer in for ICSSG driver as well?
> 

Yes please. Thanks!

>>>
>>> I also see 
>>>
>>> OMAP GPIO DRIVER
>>> M:      Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> Maybe a separate patch to remove the invalid email-id?
>>>
>> Yes, that's the plan. One of us from TI would be posting shortly.
>>
>>
> 

-- 
cheers,
-roger
