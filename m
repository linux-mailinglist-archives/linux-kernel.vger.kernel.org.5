Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47B79EDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjIMPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629793
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E18DC433C7;
        Wed, 13 Sep 2023 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694620203;
        bh=4cS9a9ki/iG8FGG+1HPrLkBPok8PcDHXuEtrMm83LOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MACifao79fmPgw3Q6VWdxD5Kg3dOOmLcvkpKXWF7foUL6wVxnLHpkx7PkxplYuYZx
         rZ1uUvdccp2eCbCf5bRfz1GnELembTf0zGe5jpsKW4etePXS9xeBgfHgAUMpYmYxtr
         N0/MjPsFtNiFYennz6Z/wkp0SKF8zYekyCfgqSwAclTQrhUSpP7qZfBMhc1FfEmSIp
         pXjPKc+/UK0NbNtpOGLiB8ZituG0zZSRGb45HTIB7RIl/dsaHzVDUOJVRVRtdrJhKK
         ePX9k0XCcG9uw41lmPlcFUfKXejWA+XKJS7LUkzsnrPjOm5csX2HMCi0LB0G+aNm/z
         +JfoHeuQ6lfQA==
Message-ID: <583b6ce6-48eb-9119-4f71-f9a5689354f2@kernel.org>
Date:   Wed, 13 Sep 2023 17:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 4/9] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-slave-v1
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
 <20230905213842.3035779-5-Frank.Li@nxp.com>
 <e9880548-11c5-2790-7c77-7ca031849182@kernel.org>
 <ZPneI4KUw8UXBUze@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZPneI4KUw8UXBUze@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 16:28, Frank Li wrote:
> On Wed, Sep 06, 2023 at 10:01:40AM +0200, Krzysztof Kozlowski wrote:
>> On 05/09/2023 23:38, Frank Li wrote:
>>> Add compatible string 'silvaco,i3c-slave-v1' for slave mode.
>>>
>>
>> No, it's the same device.
>>
>> Anyway, this was not tested.
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling. Performing review on untested code might be
>> a waste of time, thus I will skip this patch entirely till you follow
>> the process allowing the patch to be tested.
>>
>> Please kindly resend and include all necessary To/Cc entries.
> 
> Thank you for your comments. I write notes at RFC cover letter, this
> patches is not totally completed yet. I want to get more feedback about
> i3c slave mode API and configfs design, which will impact the overall
> design.
> 
> So I have not included tty mail list and you in review list.
> I send out all patches just because let i3c reviewer know how to use these
> API. 

Other people send RFC and they, surprise, expect comments. Probably
because RFC means Requests For Comments. If you do not expect comments,
review, call it somehow else, like "BROKEN", so we will know to ignore it.

Best regards,
Krzysztof

