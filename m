Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB67D288F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjJWCdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJWCdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:33:50 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A7419E;
        Sun, 22 Oct 2023 19:33:48 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 964E9490;
        Mon, 23 Oct 2023 02:33:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 964E9490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028428; bh=vzgeFGkFSqPIgHNAJHxlcyz1JCTtG7otv1v1ROzSLAw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dNUp1DWb19ut6NkvtpwLCAZbZAzFR66O2hheAg6PSWXgNxyU15EcOxwTBGy/CuWYl
         stryOpcN+K3Sbck4nSxTCq9pgm/zeQzApdlYsRBLTfuRlOUZcaOVxHuzEHcY8MsFs/
         nd60vIFxROxJZeM6RmLj1tpLIvxM0vnUoN4m6VKehunyaNatYMg+CovFxtgx8yVO/a
         BLxVVA5WfHemmai6uZUlh+vw9jddKIZ4AEeQAhoHjZBNMQx1QXScMBWH4t0MC1FSMi
         YmjA8D3Mb9NQZz7qRqh1e8QguMghXOenukBKC/eIHsmHnxKTEKu6KslbxnRaoogLmH
         8es1B1M5oisgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Charles Han <hanchunchao@inspur.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH] Documentation/sphinx: Remove the repeated word "the" in
 comments.
In-Reply-To: <20231018023046.30022-1-hanchunchao@inspur.com>
References: <20231018023046.30022-1-hanchunchao@inspur.com>
Date:   Sun, 22 Oct 2023 20:33:47 -0600
Message-ID: <87v8ayjcdw.fsf@meer.lwn.net>
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

Charles Han <hanchunchao@inspur.com> writes:

> Remove the repeated word "the" in comments.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  Documentation/sphinx/cdomain.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
> index de5d132d94c5..4eb150bf509c 100644
> --- a/Documentation/sphinx/cdomain.py
> +++ b/Documentation/sphinx/cdomain.py
> @@ -151,7 +151,7 @@ class CObject(Base_CObject):
>      def handle_func_like_macro(self, sig, signode):
>          u"""Handles signatures of function-like macros.
>  
> -        If the objtype is 'function' and the the signature ``sig`` is a
> +        If the objtype is 'function' and the signature ``sig`` is a
>          function-like macro, the name of the macro is returned. Otherwise

Applied, thanks.

jon
