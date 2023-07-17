Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45C75601C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGQKJW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGQKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:09:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6345210D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:09:12 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qLLA7-0001GZ-S3; Mon, 17 Jul 2023 12:09:03 +0200
Message-ID: <9741d5820a54707f13c099570901dd4d474548f7.camel@pengutronix.de>
Subject: Re: [PATCH v1 0/8] drm/etnaviv: Various cleanup
From:   Lucas Stach <l.stach@pengutronix.de>
To:     suijingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     loongson-kernel@lists.loongnix.cn, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 12:09:00 +0200
In-Reply-To: <73307b1e-1e0e-6265-0344-171d2700e495@loongson.cn>
References: <20230623100822.274706-1-sui.jingfeng@linux.dev>
         <73307b1e-1e0e-6265-0344-171d2700e495@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingfeng,

Am Montag, dem 17.07.2023 um 16:36 +0800 schrieb suijingfeng:
> Hi, Dear etnaviv folks
> 
> 
> Would you like to review this cleanup patch set ?
> 
> I am asking because I'm wondering that
> 
> if I should re-spin my other patch from the code base
> 
> which *with* this series applied or from the code base
> 
> *without* this series applied.
> 
> 
> I think this series looks fine, is it acceptable?
> 
I've gone through the series and left some comments. All patches that I
didn't comment on look fine to me. I'm generally in favor of taking
this series.

Regards,
Lucas

> 
> On 2023/6/23 18:08, Sui Jingfeng wrote:
> > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > 
> > No functional change.
> > 
> > Sui Jingfeng (8):
> >    drm/etnaviv: Using the size_t variable to store the number of pages
> >    drm/etnaviv: Using the unsigned int type to count the number of pages
> >    drm/etnaviv: Drop the second argument of the etnaviv_gem_new_impl()
> >    drm/etnaviv: Remove surplus else after return
> >    drm/etnaviv: Keep the curly brace aligned
> >    drm/etnaviv: No indentation by double tabs
> >    drm/etnaviv: Add dedicated functions to create and destroy platform
> >      device
> >    drm/etnaviv: Add a helper to get a pointer to the first available node
> > 
> >   drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 100 +++++++++++++-------
> >   drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  14 +--
> >   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
> >   3 files changed, 77 insertions(+), 44 deletions(-)
> > 
> 

