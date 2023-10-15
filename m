Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6D7C99DD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJOPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:53:09 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A34AAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tOrryNW9tEjw75vpDjBXunGzcoTux4+HUtzoowm8cCo=;
  b=HuUyCqrR7nsILXveJgA0E9l4MUWCW/bpyj39K3C37JozCdCh7UOAGx0q
   +HmaQatOZAuluDNCjLAQyoL2XE4YAkhaACvTF8PjZQq9BNjqfUj5xCOrL
   yYwXNqYrd6kefciI1YFwmUU8SzbtEqqt+TymlFbLx/Sm4OnBNMwp0Q/ci
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,226,1694728800"; 
   d="scan'208";a="131311740"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 17:53:05 +0200
Date:   Sun, 15 Oct 2023 17:52:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192u: Mute checkpatch error
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
Message-ID: <bfe99c7a-f01f-4ae3-a17d-1e5887a5121f@inria.fr>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Mute checkpatch error" is not very informative.

julia

On Sun, 15 Oct 2023, Gilbert Adikankwu wrote:

> Align descendant arguments to the open parenthesis as per the "Linux
> Kernel coding style" in Documentation/process/coding-style.rst
>
> Mute the following checkpatch error:
>
> CHECK: Alignment should match open parenthesis
>
> Gilbert Adikankwu (6):
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>
>  drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
>  drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
>  drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
>  drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
>  drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
>  drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
>  6 files changed, 35 insertions(+), 35 deletions(-)
>
> --
> 2.34.1
>
>
>
