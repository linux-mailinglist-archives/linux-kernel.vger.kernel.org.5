Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5887C59F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346967AbjJKRE2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347002AbjJKRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:04:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9BEC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:04:25 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qqcdA-0006Ez-NP; Wed, 11 Oct 2023 19:04:20 +0200
Message-ID: <8201caf4102cbb81ea15e87713a165590b11a684.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/5] drm/etnaviv: Various cleanup
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Oct 2023 19:04:19 +0200
In-Reply-To: <20231002111207.513297-1-suijingfeng@loongson.cn>
References: <20231002111207.513297-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 02.10.2023 um 19:12 +0800 schrieb Sui Jingfeng:
> v2:
> 	* refine on v1 and update
> 
Thanks, series applied to my etnaviv/next branch.

Regards,
Lucas

> Sui Jingfeng (5):
>   drm/etnaviv: Drop the second argument of the etnaviv_gem_new_impl()
>   drm/etnaviv: Fix coding style
>   drm/etnaviv: Add helper functions to create and destroy platform
>     device
>   drm/etnaviv: Add a helper to get the first available GPU device node
>   drm/etnaviv: Using 'dev' instead of 'etnaviv_obj->base.dev'
> 
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 93 ++++++++++++++++++---------
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 ++--
>  2 files changed, 67 insertions(+), 38 deletions(-)
> 

