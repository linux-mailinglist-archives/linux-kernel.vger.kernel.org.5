Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F096781B96
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHTALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjHTAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:54 -0400
Received: from smtpcmd0653.aruba.it (smtpcmd0653.aruba.it [62.149.156.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888BB0634
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 13:44:26 -0700 (PDT)
Received: from [192.168.1.205] ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id XSo3qPcIKvaOzXSo3qL50G; Sat, 19 Aug 2023 22:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692477865; bh=oMkQERsbWOQWYmbb8CeI2xbETyjxK7maYdZU8W7yv+Y=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=mYStym781e151ro6NvVLbugNb6RVFIAVBAROXWoopr8+2YNUr3WPxwB9j13pesI+l
         OWMAx1bbX+ha83zzXjjfU9ZieATWN69LjnEYfDiQQ/Ks7xUbOjJHXJINhiGAI99Kmk
         x8dVm49TrSsNKc1T180N49zcqTKsEdi6Gccwo0n4I8//WbmnZ7PxG7mL+iCb6qPSTJ
         mnilnp6LHD4kitwDDVBR/KC/BJ8oABUGKErKtydNMIrWyPtJG6PDzXyuXKTpGzxMfu
         J6mt+z+zvO9UDRPae85jIYeS4k7i+2uxXeShnXTXl+qNWMnZYZ/yBiMXo9kThpye2B
         EctSwoeX2rIxg==
Message-ID: <2b4f4c90-19a3-434a-9559-ea72058f7b75@benettiengineering.com>
Date:   Sat, 19 Aug 2023 22:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to
 give credits to who sponsored the patch
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <ZN65iiRiSLmXz89k@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfL4WXDWFVjPv6V4AzTF+DkLSD65XGYHDXCR6W4dNgzXeJCi0T6HLmLCiUzja8AHa75XosdlfE/T+NV3IGMVi9akuo2ifMY1CaxNJ7Zm37WyKVryUMbWn
 11A8NXq4JXwXDCvgLoEqj4Fg8ZrEbHsYK4uaXvw/nUKqKlQGo8/Jd1FnMn9LQNPUaUbX4civQhaaebnRhBOpOjA81ZjRp+MUT0UqxwAWv7JlmkgmeZP7u0vH
 PP681rgpR6wZOkIjc1EQrPG+yYRg812bnMfEAjvEAA8jj8iGvQ14vyaSh3uhiegLlHlvcbVpFbOVkcWjXsplANHGWoVkdoJMtUdLNgtdaJ8kLKJsPcscYNdz
 7bPSHOeCry/rQcL8TfEdjOmuDkXHlUuknuzOPbn0krk919wDDQ8=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew, Laurent,

On 18/08/23 02:21, Matthew Wilcox wrote:
> On Fri, Aug 18, 2023 at 02:23:48AM +0300, Laurent Pinchart wrote:
>> Just adding one data point here, without judging on the merits of this
>> proposal. I've been requested previously by customers to increase their
>> visibility in the kernel development statistics, and the way we found to
>> do so was to sign-off patches with
>>
>> Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
>>
>> (where "customer" is to be replaced with the customer name).
> 
> I quite like Sponsored-by: but yet another approach could be the
> same as that used by those of us whole use personal email addresses
> while being employed by someone.  So my SoB is:
> 
> Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> but you might have (eg)
> 
> Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
> 
> and then when working for another sponsor:
> 
> Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>

This is a good solution too. It's only that it gives me the idea that
Laurent Pinchard actually works inside Coca-Cola then Ford and so on.
At the least this is my understanding at first sight.

What I've found not easy at all instead in my patch is to deal with the
Acked-by: from the Sponsor, because he could have to do that for(let's
say) 100 patches, and it becomes not easy to check.
I've been pointed that there is already the DCO the prevents from fake
Sponsored-by: tags removing the need to send Acked-by: from the Sponsor.
So I would modify this patch.

But before I'd really like to have more feedback by someone else if 
possible.

-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
