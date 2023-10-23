Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF07D28A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJWClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJWClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:41:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42B13E;
        Sun, 22 Oct 2023 19:41:11 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 39F77490;
        Mon, 23 Oct 2023 02:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 39F77490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028871; bh=zc4kfFzHO48AWJGRzKmqCj9dpg/VKmkjjYg4dvWoePo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZKwQb1XMeAOTpud0M+II07/7UK8ERKvIIE7XClNo21B8vKxsuXp655kxTiue4SAo8
         T6pDm19f212PQVGGBFU16mPIE1egAeNeNfUxuSWwRLtE8bFF9QFU6W+xsHr/+mx8jK
         ePDk/5nOpuqo9KOI5eJ1wVERUesVz8D1rVO0z6Q0Q+jXILIyB/hfV2VCkyrQwuEIPm
         K0X9gmgSuYfVlYMaw7f+cOQHRTxTJZSzwfJorxbPg3vZVSxw7knFuPKKYxzKlJcoVP
         Y6vOdRoM39MJ90gskjt8LaEOWpYfJ7g7O63fsLx0LadtH4ME27yMa/Hw+pV7WqVYBS
         E+9fectTnOYfQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>, linux-usb@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] docs: usb: fix reference to nonexistent file in UVC Gadget
In-Reply-To: <20231022185311.919325-1-vegard.nossum@oracle.com>
References: <20231022185311.919325-1-vegard.nossum@oracle.com>
Date:   Sun, 22 Oct 2023 20:41:10 -0600
Message-ID: <87edhmjc1l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Fix a typo in the path of this reference.
>
> Fixes: 094f391013ba ("docs: usb: Add documentation for the UVC Gadget")
> Cc: Daniel Scally <dan.scally@ideasonboard.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/usb/gadget_uvc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/usb/gadget_uvc.rst b/Documentation/usb/gadget_uvc.rst
> index 80a1f031b593..bf78fba3ce23 100644
> --- a/Documentation/usb/gadget_uvc.rst
> +++ b/Documentation/usb/gadget_uvc.rst
> @@ -126,7 +126,7 @@ might do:
>  	create_frame 1920 1080 uncompressed yuyv
>  
>  The only uncompressed format currently supported is YUYV, which is detailed at
> -Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst.
> +Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst.

Applied, thanks.

jon
