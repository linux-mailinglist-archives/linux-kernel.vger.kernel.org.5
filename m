Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85977BDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHNQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjHNQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:10:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F8F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:10:03 -0700 (PDT)
Received: from [192.168.2.208] (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46F2866071DA;
        Mon, 14 Aug 2023 17:10:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692029401;
        bh=0xJrszvPybOm12lHAmUrD0d8TVqW7yCnGXM4HyvXR6k=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lMWfHHInDl7McdWabvvCSPp+7mEu4QrrdaFd/04HjgukHFPEJl4SzlQedoiPeux2D
         xyUMfx7RPqyBwjFGukb5yIt9OOILCUvX70zU8uFmPS/NLm7w6XXS4xP5LyhNhKrJPP
         BOEFTL6pxkIZBjaJ75Pei/iluGy52TCb6UBf+dHp17OLdQ/twYHkRygdssUKbkWuPE
         zqWjrAr0DzTv717w3H0ACAOP6+iMD4ME+XYwrKhE8HUpif3xrY9b3JqftOh/uzFd+5
         /ngxmr4oFbGPdDhfW16EccrKNIosLnIcuiIaJafMEyMbxn0q+umkZeY1iInlScMxHP
         PPLCAD12c2JDA==
Message-ID: <39e11e3a-5874-e388-f1bd-0e568de7fc84@collabora.com>
Date:   Mon, 14 Aug 2023 19:09:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] MAINTAINERS: Add Boris Brezillon as Panfrost driver
 maintainer
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 11:15, Dmitry Osipenko wrote:
> Add Boris Brezillon as Panfrost driver maintainer. Boris is a new lead
> developer of the Panfrost Mesa driver and main developer behind the
> upcoming Panthor kernel driver that will serve next-gen Mali GPUs.
> 
> Remove Tomeu and Alyssa, who left Collabora and stepped down from working
> on Panfrost.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d6536fef2fc..08dc75916148 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1615,9 +1615,8 @@ F:	drivers/gpu/drm/arm/display/komeda/
>  
>  ARM MALI PANFROST DRM DRIVER
>  M:	Rob Herring <robh@kernel.org>
> -M:	Tomeu Vizoso <tomeu.vizoso@collabora.com>
> +M:	Boris Brezillon <boris.brezillon@collabora.com>
>  R:	Steven Price <steven.price@arm.com>
> -R:	Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc

Alyssa acked this patch on IRC and asked to repost it on the ML, here it is:

Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

-- 
Best regards,
Dmitry

