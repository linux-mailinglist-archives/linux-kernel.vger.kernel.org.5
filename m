Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85778B778
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjH1Soc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjH1SoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67626B3;
        Mon, 28 Aug 2023 11:44:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 152117DB;
        Mon, 28 Aug 2023 18:44:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 152117DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693248250; bh=6VI2H7gLRgPr4ukXUvV7bf1IPmuT5gXIgiO43jCaM7s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Nipej7Om2wYDdE/JHiIB4X+DAqfpf6NRVhlgRiYYg2dxmQNopi9Sv0zo+p2eT4467
         MPYhYqCzfJABVNyK/0DC1G8Js2BeaqwF8BqSNx3e3CQrMRC8jLnAKdk9Bw/CNSXOCh
         JC0+HfxlEH54jiqEe8RF44GIhmx0Cu7qstDxCsq5n1gh3H8iN/h3xmptWAmuKuTG3H
         W1ZPvuZ/rkkk26Xyw/qQsoA2hIQ322ER23LfNKduv8jmffBlZGEA/Vn4Mv3l75m5qo
         8X46wlbxuWkBoe7zcQ46t3qo6+Kxy5KktS93gnp3eU6qYM+zswnuK92ywuxvue1bQw
         /FzHq9nUHLkeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] input: docs: pxrc: remove reference to phoenix-sim
In-Reply-To: <20230824-pxrc-doc-v1-1-038b75a2ef05@gmail.com>
References: <20230824-pxrc-doc-v1-1-038b75a2ef05@gmail.com>
Date:   Mon, 28 Aug 2023 12:44:09 -0600
Message-ID: <877cpf0zye.fsf@meer.lwn.net>
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

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> The reference undeniably points to something unrelated nowadays.
> Remove it.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/input/devices/pxrc.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/devices/pxrc.rst
> index ca11f646bae8..5a86df4ad079 100644
> --- a/Documentation/input/devices/pxrc.rst
> +++ b/Documentation/input/devices/pxrc.rst
> @@ -5,7 +5,7 @@ pxrc - PhoenixRC Flight Controller Adapter
>  :Author: Marcus Folkesson <marcus.folkesson@gmail.com>
>  
>  This driver let you use your own RC controller plugged into the
> -adapter that comes with PhoenixRC [1]_ or other compatible adapters.
> +adapter that comes with PhoenixRC or other compatible adapters.
>  
>  The adapter supports 7 analog channels and 1 digital input switch.
>  
> @@ -41,7 +41,7 @@ Manual Testing
>  ==============
>  
>  To test this driver's functionality you may use `input-event` which is part of
> -the `input layer utilities` suite [2]_.
> +the `input layer utilities` suite [1]_.
>  
>  For example::
>  
> @@ -53,5 +53,4 @@ To print all input events from input `devnr`.
>  References
>  ==========
>  
> -.. [1] http://www.phoenix-sim.com/
> -.. [2] https://www.kraxel.org/cgit/input/
> +.. [1] https://www.kraxel.org/cgit/input/

Hmm...that does indeed seem like a link that lacks value for kernel
development.  Patch applied, thanks.

jon
