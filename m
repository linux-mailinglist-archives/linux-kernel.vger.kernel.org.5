Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65C7BA48E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjJEQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbjJEQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F862C28D;
        Thu,  5 Oct 2023 07:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C0C36AE6;
        Thu,  5 Oct 2023 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696511505;
        bh=AWa9aB3awlpYYHRZ8aPyhCDQYyEoopdnUDfWPzETdes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6vWk8D7UqoPbid+0FhB6M6Imd4+W70F2pTdH4/Q4Di/hpvz6wS5ho/RNBKGg1ApF
         I+v2H2MPCvEXJoj4nkKuWSJtgT6mS0QSkE5fmm2WKZ0F/LW4+3SWD4KHoGyVNqHj31
         ipyxc7LWFsO2Qe/iZ2Kb13wMsU/toS6ohUd2Po+uVKYoRed2sixluHhtMbPI10Ow/g
         qdSe9zZuvYVUPKJ8BgruPfeIHRVHVFHfl8tkzs8++3ZK9EQfhfg8+hbthg8XroCT27
         x+ikYyIEkHRvM3/Yj7+MoN6T7w5CN7PAEeHBM2W+fqa2NYFNM0PAL+YDWrRKsvQyH/
         PqfVGoFvMSlzw==
Date:   Thu, 5 Oct 2023 14:11:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Match data improvements for pca955x driver
Message-ID: <20231005131140.GC681678@google.com>
References: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023, Biju Das wrote:

> This patch series aims to add match data improvements for pca955x driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Added Rb tag from Andy.
>  * Dropped tabs from struct pca955x.
> v1->v2:
>  * Added Rb tag from Lee Jones for patch#1.
>  * Adeed patch#2 for cleanup of OF/ID table terminators.
> 
> Biju Das (2):
>   leds: pca955x: Convert enum->pointer for data in the match tables
>   leds: pca955x: Cleanup OF/ID table terminators
> 
>  drivers/leds/leds-pca955x.c | 71 +++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 42 deletions(-)

These no longer apply.

Please rebase and submit a [RESEND] so I can apply them.

-- 
Lee Jones [李琼斯]
