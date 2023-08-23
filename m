Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6E7863E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbjHWXTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjHWXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:19:25 -0400
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28D10C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:19:21 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.122.243])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Yx89qku9EgpIyYx89qIqzt; Thu, 24 Aug 2023 01:19:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692832758; bh=xQTbOVG87TK9JPqsKuzRZJRYGXmtTFs9rbM9Q0xQjtY=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=PxddRZU0GUt1fBjLGV0hlO/shNw6wr3jPLezBDiPcV+WC1ZEyhcWF4cd3zK4XshLc
         w6dv7WfIEfnR0Aqqg+czCOCfl7sPCH+i4Zubxc+XKd7Kyu9lBhPJYDwmN+W3S1zgIh
         /GVxlCoU9rG7QfCsBfgGTd9PVbM7JH+TM8QdEjn44IyDZNEkbvn1TbX1aakIaCQxzm
         wjx4EIVeHG/UxzK9jP5lpphGTEQW6L3j5JyyoomonWT3v6geeL37cgoYNOuwBXQ4Rp
         6VIph5dabEuXLzWqF235gGUVcrrApeH3xBU39CyexDGz3ccE9DTW0TaLhpWCefjP9v
         N/ssxNs0oy25g==
Message-ID: <8ebb9e45-a69e-783b-3c93-30a7c27bdbc6@benettiengineering.com>
Date:   Thu, 24 Aug 2023 01:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to
 give credits to who sponsored the patch
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
 <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJWR0OmGkhmDtClfBYYvNLsTPkH9pYsZ6wtECtnDH4auxntA/aai4Q8AFi8QazHctJVaXV0QSlDams1ArtAuMQViNxX25Tt/NmdYP4zOsBefVD2GbTi2
 +2+LptVPzOkSCRtaDFJ9LfemY1Jv7dUKZstNlHg5/YGT9BR0l0YDovRLUFchbnayk7M4A+6adjyiYsiBRct+zldr/+SfrH0Rm+tigfGxlNHHtkQiUQoLqI4B
 kiob6b7VPSJIq+38UzoVimYpt8/vbyx9ncVEE0i1vopv1fgSd6GwVV7o/9FkcE2BSsngPLejOT3JOW0AozaoEzCXO6oBBGBGblgWQSKfvRWeZpeMflmGTdhA
 QYZ01YUDcuskSmU/ZbDehjYx+5zjJ40QCGFJq0lIwKGPMDbpzIsaE6jXOnbP/nS8LUrUxnF1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert, All,

On 21/08/23 09:40, Geert Uytterhoeven wrote:
> Hi Giulio,
> 
> On Sun, Aug 20, 2023 at 2:35 AM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>> On 18/08/23 01:23, Laurent Pinchart wrote:
>>> On Fri, Aug 18, 2023 at 12:09:57AM +0200, Giulio Benetti wrote:
>>>> Sometimes it happens that a Company or a Physical Person sponsors the
>>>> creation and/or the upstreaming process of a patch, but at the moment
>>>> there is no way to give credits to it. There are some commit that include
>>>> a sort of tag "Sponsored by" without the dash to avoid
>>>> scripts/checkpatch.pl to complain but a real standard has not been defined.
>>>> With this patch let's try to define a method to give credits consistently
>>>> including an acknowledge from the sponsor. The goal is to improve
>>>> contributions from companies or physical persons that this way should gain
>>>> visibility in Linux kernel and so they should be more prone to let the
>>>> work done for them for to be upstreamed.
>>>
>>> Just adding one data point here, without judging on the merits of this
>>> proposal. I've been requested previously by customers to increase their
>>> visibility in the kernel development statistics, and the way we found to
>>> do so was to sign-off patches with
>>>
>>> Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
>>>
>>> (where "customer" is to be replaced with the customer name).
>>
>> this approach works good for the developer because of the +customer
>> mailbox capability but in term of appeal for the final customer I've
>> been told(by the customer) he would really like more the "Sponsored-by:"
>> way. To tell the truth while I was looking for an existing alternative
>> I've found the commits with "Sponsored by:" pseudo-tag that look cooler.
>>
>> This is my taste of course and the taste of one of my customers, but
>> to me it's like having a brand shown:
>> Sponsored-by: Sponsoring Company
>> vs:
>> Signed-off-by: Giulio Benetti
>> <giulio.benetti+sponsor.company@benettiengineering.com>
> 
> Personally, I would respond "I'm sorry, but the only advertising
> space we offer are Copyright headers (for employees) and
> "user+customer@..." or "name (customer) user@..." (for contractors).

This is a good answer. So these are the 2 possible ways to give credits
to sponsors.

Does it make sense if I send a patch describing exactly this?
This is because my finding was only "Sponsored by" that looked good
to me. So I can avoid other possible pain for the future.

> And this is a separate tag, so it's harder for the analysis tools
> (whose output your customers must be interested in, too?) to
> match the tag to the actual Author/Reviewer/...

Right

>> If I am the customer I'd really prefer the first option.
> 
> You are aware this will cause lots of work for the customer, too?
> (See below).

[ SNIP ]

>>>> +In both cases, to prevent fake credits, either the company or the person should
>>>> +send an Acked-by tag placed right under Sponsored-by tag using the same form
>>>> +described above. So for example if the patch contains::
>>>> +
>>>> +    <changelog>
>>>> +
>>>> +    Sponsored-by: Company Name <mail@companyname.com>
>>>> +    Signed-off-by: Developer Name <developer.name@developername.com>
>>>> +
>>>> +The result including the answer from the sponsor must be::
>>>> +
>>>> +    <changelog>
>>>> +
>>>> +    Sponsored-by: Company Name <mail@companyname.com>
>>>> +    Acked-by: Company Name <mail@companyname.com>
>>>> +    Signed-off-by: Developer Name <developer.name@developername.com>
>>>> +
>>>> +This way the sponsor agrees to the usage of this tag using its name.
> 
> This is also causing more work for maintainers: now they have to check
> if any Sponsored-by tags are present, and track if there is a response
> with a matching Acked-by tag...
> 
> And obviously they should postpone applying the patch until a
> confirmation response is sent... which may never happen...

Yes it came into my mind and I wanted to rely only on DCO dropping the
part of acked-by tag. But there are too many cons for Sponsored-by approach.

So I will go for one of the 2 ways I've been pointed.

Thank you
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
