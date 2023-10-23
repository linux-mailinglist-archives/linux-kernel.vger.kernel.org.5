Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26577D289F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjJWChc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJWCha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:37:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494913E;
        Sun, 22 Oct 2023 19:37:29 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 255E460A;
        Mon, 23 Oct 2023 02:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 255E460A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028649; bh=3XNMZh3h7FMMi1jgKxnN52FVKiMqUAhHdOLkOhZOqOs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nVFHMd+XYGlze5muwynkNvkZHcrIv3TVD2ehLA/thuE+0bgWHl9uxShdViI4yfsrp
         yCzOdrUZmGH3MhSOZlMOb7TXmA4kfSzsAU5qWIweDODHssgHxu7FoVvnq5Yfi7+rhE
         33uRXkkCwTpxyY7LeIoP7kV9a/OdorQ48oWB1zUOP9ugAiLLdvJgNKNHHswhoBVPcP
         sofyAYURzRHPn24zcZMckkCNV/r1oMx5LXNjEGm5YZ70Iva8PWRa+Yqi1rGYryrmSY
         kvgvExXRk0hifbowAbbqii43dPwCjAqT4f2Xi4yD9BNbdo2v6txAp8uuvmH6FZkqFN
         egOvafoX9a/Sw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jade Lovelace <lists@jade.fyi>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo in dynamic-debug howto
In-Reply-To: <20231019231655.3162225-1-lists@jade.fyi>
References: <20231019231655.3162225-1-lists@jade.fyi>
Date:   Sun, 22 Oct 2023 20:37:28 -0600
Message-ID: <87mswajc7r.fsf@meer.lwn.net>
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

Jade Lovelace <lists@jade.fyi> writes:

> Signed-off-by: Jade Lovelace <lists@jade.fyi>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 0b3d39c610d9..0c526dac8428 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -259,7 +259,7 @@ Debug Messages at Module Initialization Time
>  
>  When ``modprobe foo`` is called, modprobe scans ``/proc/cmdline`` for
>  ``foo.params``, strips ``foo.``, and passes them to the kernel along with
> -params given in modprobe args or ``/etc/modprob.d/*.conf`` files,
> +params given in modprobe args or ``/etc/modprobe.d/*.conf`` files,
>  in the following order:

Applied, thanks.

jon
