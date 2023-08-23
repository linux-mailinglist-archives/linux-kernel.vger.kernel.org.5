Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FCD7863F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjHWX3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjHWX3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:29:22 -0400
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2370310C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:29:19 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.122.243])
        by Aruba Outgoing Smtp  with ESMTPSA
        id YxHpqkyttgpIyYxHpqItFH; Thu, 24 Aug 2023 01:29:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692833358; bh=Djb+ydYILif3vT93OqYp68/ll5P3PBwrXaYX2I8egtU=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=BZKvsYkKrnZW3W/n3AnAF9s8sGbzgrd0UyKTNL8YFzLNsvraRFrDcwHwkldKivP10
         pCnLZABiMuiEqU2K080RCnmMwotlIN7aLnC33irTwQZ3CtwDIHjkJhxiejCJVQCSDo
         5RqW6hYIFzibfbdgmBQSjGr3S2W7O64DEe2DfFcjHcP4QhYpzSST3tuSwA+MW87nJU
         zU5c95PYwX/BxL+o0G/YLyeBPo3vbVnd6pOZYtXmygHhjNKgQhBH52TSoVi+YPEc8t
         hcYCuuj6m/3vpP64+3jpGhqi2jjn8TndzowatakJokkcpHt01zALjA2g1dS61rXgrM
         O3YSoT7h6jRXg==
Message-ID: <729df0fd-45a5-53d9-e2c1-e76b0e3ef10e@benettiengineering.com>
Date:   Thu, 24 Aug 2023 01:29:17 +0200
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
X-CMAE-Envelope: MS4xfEh0E2t4uzbuURzqWhLE6FKBUNyZedG5b95a61IQ26l7DEEkRD6xjvfOndAOByDL087hxgN1xoPmPHzKMJfvfOfUgl6MFM7MlB4M4zWRRd0ykeML1UNw
 ZA08lL6RFc66Ug0te6ABUT7tTKcpOVmTNTJqmjg3Za92JMCGJ3b7IFqAO8d2woFfzegl5ttLZM5A5OXol82sToEaC9JqoI3F9Oqpp5hZeWHq20/uLV59YRai
 TqNBDuxx3mFs6ReerR9s7YVHBmynZ8iB4WmgjO5uRG0IpOkgp9Nq1LpDB7p1HlS9q6ujuLXpCBFLitMCJPiFAj90/fQVbwYzYvWScYNPC55rBF9Pk7CjZCkp
 CtXQgB2vjVHmLxYvzGync5wHXdv2hRo7F8OutZE3nXv/tUuFfMyb20lJZ5Ka3VFGcpF0mldM
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew, Laurent, All,

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
> 

Thanks a lot for pointing me the existing ways to give credits I was not
aware. I will pick one of the 2 and use it.

Both can be used by analysis tools.

Thanks again for taking care.
Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
