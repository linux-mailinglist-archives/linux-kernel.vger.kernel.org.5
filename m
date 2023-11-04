Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7897E1053
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjKDQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:16:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2AFB;
        Sat,  4 Nov 2023 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=RT5Ut20jrhX/hrW/CDlt1qCBPlWYiI4JJZPBleWMyLY=; b=nyMtB7I00lmrkt77VjXaHJZ62O
        guNRsSIyM2Myefi3Fxh8DhOUT1p6ByZfVmonAqzsxXUngTXeHV9BN3rs3ep7+31lVOFk9e+Mmqwy0
        gYlc2k1PvqyQJfXTVLTdyg47U+xWBCWOfNcjNkXirRT9Fcd8qeWL0R+HC61Nfu430CdqN2WU++eA2
        hiWC4ooOjbjytW7rihZ7ZJJ28dSL5ZCo77R280zL4l5bna/jeS5SMqu8OlalQDCfg0MZlErnqlSp1
        dJYpedaM9QLcJ3i/1bs0/8wHgWvBEg10SrYXyCyosDXrKb8tSq7eYK0JeOY5086dkiPISdt5tEV0c
        83EuIEFQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzJK9-00DaSg-0e;
        Sat, 04 Nov 2023 16:16:37 +0000
Message-ID: <439e83e3-cf56-4437-ba20-1fcf90ce8089@infradead.org>
Date:   Sat, 4 Nov 2023 09:16:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc: Use shared font data
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Dr. David Alan Gilbert" <linux@treblig.org>, davem@davemloft.net,
        sam@ravnborg.org, benh@kernel.crashing.org,
        akpm@linux-foundation.org
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au
References: <20230807010914.799713-1-linux@treblig.org>
 <ZUWch6-cSpcafPsF@gallifrey>
 <b09106ada4774c7860afc85a28cc564d220cdc7f.camel@physik.fu-berlin.de>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b09106ada4774c7860afc85a28cc564d220cdc7f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/23 01:53, John Paul Adrian Glaubitz wrote:
> Hi Dave,
> 
> On Sat, 2023-11-04 at 01:21 +0000, Dr. David Alan Gilbert wrote:
>> The PowerPC version of this just got merged (0ebc7feae79ac, thanks
>> Michael!), but I've not had any interest from anyone to merge
>> this SPARC version; I'd be happy to rebase and text on current
>> head if someone has an idea how to get it merged.
> 
> Since both Debian and Gentoo are still maintaining their SPARC ports, we're
> naturally interested in getting such improvements merged. However, the SPARC
> maintainer, David Miller, has been inactive for some time and I currently don't
> know what the state of his role as the maintainer is.
> 
> I will try to reach out to him to find out what the state of things is.
> 
> Thanks for your continued interest in getting this improvement in.

Hi,
I have a couple of SPARC patches that I would like to see merged also,
if you have any success:

https://lore.kernel.org/lkml/20230703230153.19421-1-rdunlap@infradead.org/
https://lore.kernel.org/lkml/20230703230202.19844-1-rdunlap@infradead.org/

thanks.
-- 
~Randy
