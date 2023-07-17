Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375CB755EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGQIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:50:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EF1AE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:50:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8805B6607008;
        Mon, 17 Jul 2023 09:50:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689583836;
        bh=FA0WJ/4w/kSzok3YACKCV67AqsSFqdugv/Hgl8UwAzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PcSduDWtb1r5ca/n7wrdp7xyWfHgTXKEhzmpEusqlt6iuTc5Yp0DTaMI0gchYMUU6
         d09xC3daHVNl4eYpKXdCtTULqDgLYvJaqu/CisyjR9EfMb9m/48VwtqrtXQvAn2ajk
         604rpQLlvC8ANUeCmYBG9gqepAqN8meE8uhKFE3luHoxPQCVIqVRwDlzVOcj2pmgWP
         LhewRDKOao5MtmsyS8iUNT3n0Hrl2ulX1nLnSB1GGwgzyQDz+iYT9NXkYlp0+2hyXc
         wq3h5TLvSupI3PTtBQdS55ZVxVF3dEkUNlnOp/gJOp6ho0n+xHbr2WyB+o2FAk3h3f
         9dMLmQBg5lw8w==
Date:   Mon, 17 Jul 2023 10:50:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1] MAINTAINERS: Add Boris Brezillon as Panfrost driver
 maintainer
Message-ID: <20230717105033.4805a864@collabora.com>
In-Reply-To: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
References: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 11:15:44 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

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

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

>  R:	Steven Price <steven.price@arm.com>
> -R:	Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc

