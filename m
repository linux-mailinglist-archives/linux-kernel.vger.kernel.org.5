Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193A7FF5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjK3QaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3QaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E31A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92729C433C7;
        Thu, 30 Nov 2023 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701361822;
        bh=ZC5pdnxtaALPr6AWPyuqbZFGRFQlJPG/PBmeu7mFd8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j9fUKgwHvAvpJw63f0OOVvKu178+7dLQWz79YoLP6ltAqLBv/iEYG68qz3K87fUug
         4pc6HKgv7hslYeC/wBGkZYsK0oRaz8DX6zzgnOcE3uxvBr9HnlieG/rCIEAESTCAJw
         mwQe49iP1ijKKhRO0BVXrlDfZz5dBzPSbqVJKD2Y=
Date:   Thu, 30 Nov 2023 08:30:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Antti Palosaari <crope@iki.fi>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Antti Palosaari
Message-Id: <20231130083021.a99013c58318ebe66b408f2d@linux-foundation.org>
In-Reply-To: <9da4252b-269b-c25b-c485-afdcd8207268@iki.fi>
References: <20231130083848.5396-1-bagasdotme@gmail.com>
        <9da4252b-269b-c25b-c485-afdcd8207268@iki.fi>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 10:43:16 +0200 Antti Palosaari <crope@iki.fi> wrote:

> Hello,
> 
> On 11/30/23 10:38, Bagas Sanjaya wrote:
> > He is currently inactive (last message from him is two years ago [1]).
> > His media tree [2] is also dormant (latest activity is 6 years ago),
> > yet his site is still online [3].
> > 
> > Drop him from MAINTAINERS and add CREDITS entry for him. We thank him
> > for maintaining various DVB drivers.
> > 
> > [1]: https://lore.kernel.org/all/660772b3-0597-02db-ed94-c6a9be04e8e8@iki.fi/
> > [2]: https://git.linuxtv.org/anttip/media_tree.git/
> > [3]: https://palosaari.fi/linux/
> > 
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> > Essentially no change from RFC [1]. However, since there is no response on
> > RFC (including from Antti), let's drop him so that Cc: lists can be
> > a bit shorter.
> 
> Acked-by: Antti Palosaari <crope@iki.fi>

A shame, but thank you for all your work!
