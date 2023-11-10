Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF57E7E38
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjKJRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjKJRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:38 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72F3D540;
        Fri, 10 Nov 2023 08:21:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAGLlns116980;
        Fri, 10 Nov 2023 10:21:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699633307;
        bh=7UT7IE7MwQ52DU56ZEU9VxjnIavn9yIJBHhLeQX03f4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mikYvPrevZMt7LrQaEi4I0KE65Q3004hPcDw13Qf9vwFA3dPQ4WJdI5PIp9E8JR2U
         1aEZ/9wH25IAfWQ50GQtbZbzf3q4uhZVCk2+xA0doVGgSCKOW4y+TMboD7zD28/Vbb
         5rWhll0H7LDY6eC923g/A/JzneoukFYlewnMEoB8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAGLlSl087796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 10:21:47 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 10:21:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 10:21:47 -0600
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAGLiL3063419;
        Fri, 10 Nov 2023 10:21:44 -0600
Message-ID: <e96bd133-7bc7-b2ae-4d70-69f2ad5c9aff@ti.com>
Date:   Fri, 10 Nov 2023 21:51:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <nm@ti.com>, <srk@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>
References: <20231110084227.2616-1-r-gunasekaran@ti.com>
 <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
 <44f68604-b37d-56d9-6fc1-4c4cc503abd3@ti.com>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <44f68604-b37d-56d9-6fc1-4c4cc503abd3@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 3:08 PM, Ravi Gunasekaran wrote:
> Roger,
> 
> On 11/10/23 2:21 PM, Roger Quadros wrote:
>> Hi Ravi,
>>
>> On 10/11/2023 10:42, Ravi Gunasekaran wrote:
>>> Grygorii is no longer associated with TI and messages addressed to
>>> him bounce.
>>>
>>> Add Siddharth and myself as reviewers.
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
>>>  MAINTAINERS | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7b151710e8c5..bd52c33bca02 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>  F:	drivers/counter/ti-eqep.c
>>>  
>>>  TI ETHERNET SWITCH DRIVER (CPSW)
>>> -R:	Grygorii Strashko <grygorii.strashko@ti.com>
>>> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
>>> +R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
>>
>> Could you please add me as Reviewer as well. Thanks!
> 
> Thanks for volunteering to be a reviewer.
> 
> I posted a v2 adding you as a reviewer.
> https://lore.kernel.org/all/20231110092749.3618-1-r-gunasekaran@ti.com/
> 
>>
>>>  L:	linux-omap@vger.kernel.org
>>>  L:	netdev@vger.kernel.org
>>>  S:	Maintained
>>
>>> F:      drivers/net/ethernet/ti/cpsw*
>>> F:      drivers/net/ethernet/ti/davinci*
>>
>> What about am65-cpsw*?
>>
>> And drivers/net/ethernet/ti/icssg/*
> 
> I would prefer a separate entry for ICSSG. Will let Danish comment on this.
> 

Sure, I will share a separate patch for this. Roger, do you want me to
add you as a reviewer in for ICSSG driver as well?

>>
>> I also see 
>>
>> OMAP GPIO DRIVER
>> M:      Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Maybe a separate patch to remove the invalid email-id?
>>
> Yes, that's the plan. One of us from TI would be posting shortly.
> 
> 

-- 
Thanks and Regards,
Md Danish Anwar
