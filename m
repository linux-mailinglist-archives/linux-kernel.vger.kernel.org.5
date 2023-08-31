Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D478EFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjHaOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHaOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:52:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8FB7CC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:52:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4C84C15;
        Thu, 31 Aug 2023 07:53:17 -0700 (PDT)
Received: from [10.1.26.48] (e122027.cambridge.arm.com [10.1.26.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B7A3F64C;
        Thu, 31 Aug 2023 07:52:36 -0700 (PDT)
Message-ID: <7d35a0f4-031b-d6a8-e0df-a97fc6b68b3b@arm.com>
Date:   Thu, 31 Aug 2023 15:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] MAINTAINERS: Add Boris Brezillon as Panfrost driver
 maintainer
Content-Language: en-GB
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230822052555.538110-1-dmitry.osipenko@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230822052555.538110-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 06:25, Dmitry Osipenko wrote:
> Add Boris Brezillon as Panfrost driver maintainer. Boris is a new lead
> developer of the Panfrost Mesa driver and main developer behind the
> upcoming Panthor kernel driver that will serve next-gen Mali GPUs.
> 
> Remove Tomeu and Alyssa, who left Collabora and stepped down from working
> on Panfrost.
> 
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> Acked-by: Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

FWIW:

Acked-by: Steven Price <steven.price@arm.com>

Steve

> ---
> 
> Changelog:
> 
> v2: - Added acks from Boris, Alyssa and Tomeu. Tomeu answered with ack
>       to the v1 email, though he answered to me only and not "to all",
>       so it's not visible on the ML.
> 
>     - Made Boris' entry first as was requested by Rob Herring.
> 
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd882b87a3c6..b2fc771e1f2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1614,10 +1614,9 @@ F:	drivers/gpu/drm/arm/display/include/
>  F:	drivers/gpu/drm/arm/display/komeda/
>  
>  ARM MALI PANFROST DRM DRIVER
> +M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Rob Herring <robh@kernel.org>
> -M:	Tomeu Vizoso <tomeu.vizoso@collabora.com>
>  R:	Steven Price <steven.price@arm.com>
> -R:	Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc

