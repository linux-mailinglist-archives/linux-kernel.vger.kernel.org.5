Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA9775215
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHIEyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:54:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A6172A;
        Tue,  8 Aug 2023 21:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hB8XQbYFdb0Z9/ylbFbqW6q07ipxUwcAY2KZjsOchlU=; b=uRGY4KTxrPxI7ASoL8Fo2YvHIS
        CDgeMBt54w4wPVl99ab7UP3U9SlJbuxxh1FAstcJf6ApVf2RdSEfBig/vMN+qRKAAhKRW1wxP5a4H
        WVVBMB8vGN8tKRK8iVqejZe+74Qr4tvTTmc7blHtTrmyjsDUrmp0QkMWlgqkhjPdqT5asqyIIqyUj
        eJo4sDZisIdxqx8jEQbHB8xL6ffZN+h+8eAspCVypHV98asKH8oNbpVOmH+GA3Mx+8MJ3KUi6Iqcv
        0Nm1fuiYpOtCsZc907FNWMo82O6/1B3YnKhT0cbCBH2D9EqA/l6q9FeL7O1BxwdhLl3TNnHH4uqKR
        nvZxTlWA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTbDd-0042b2-0z;
        Wed, 09 Aug 2023 04:54:49 +0000
Message-ID: <aac7b4bf-e961-6d3f-a4d3-01d56a19613d@infradead.org>
Date:   Tue, 8 Aug 2023 21:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Documentation: RCU: fix section numbers after adding
 Section 7 in whatisRCU.rst
Content-Language: en-US
To:     Wei Zhang <zhangweilst@gmail.com>, corbet@lwn.net,
        paulmck@kernel.org, rostedt@goodmis.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230808155811.550575-1-zhangweilst@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230808155811.550575-1-zhangweilst@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 08:58, Wei Zhang wrote:
> Signed-off-by: Wei Zhang <zhangweilst@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/RCU/whatisRCU.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index e488c8e557a9..60ce02475142 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -59,8 +59,8 @@ experiment with should focus on Section 2.  People who prefer to start
>  with example uses should focus on Sections 3 and 4.  People who need to
>  understand the RCU implementation should focus on Section 5, then dive
>  into the kernel source code.  People who reason best by analogy should
> -focus on Section 6.  Section 7 serves as an index to the docbook API
> -documentation, and Section 8 is the traditional answer key.
> +focus on Section 6 and 7.  Section 8 serves as an index to the docbook
> +API documentation, and Section 9 is the traditional answer key.
>  
>  So, start with the section that makes the most sense to you and your
>  preferred method of learning.  If you need to know everything about
> 
> base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc

-- 
~Randy
