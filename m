Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75D97F5C05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjKWKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:14:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207ED48;
        Thu, 23 Nov 2023 02:14:06 -0800 (PST)
Received: from [100.92.221.145] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C58C6607390;
        Thu, 23 Nov 2023 10:14:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700734445;
        bh=1AzfTh3xW+R7jMoKi0iXP3NjuJBvCg9wANdNbnewW9A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cisBLx8H2xJ/JQT35+N+k8CsxmBeBkHf3H7mYH9wRTBTyCxPb/Ev+fmMqupAigRZ8
         Zi1A0RpzrwtsFo3INoctqZDCsQ5ZnTklwIgAF038NxFSIhEy2dsgy/q0XntUkVhPbN
         Ad4iMHzZkJSG4xnX2q9dyF2iPPPmZqXu2jcWvAc0XPqlPDUd3RPChgNO7+MKEGAp+d
         j5U/pFXjbyethUNEVJSvfKr+eNDtIn/T2axJOIvIziS2oNSLo7PGHg4qc0sV3ajYz4
         bCPh1Q4RdG4ZAm5SHm0n/Tis1gyPslTleBBN9PebmpBFXf8KKhIhdv2GJVNixfyJc3
         wKG0m++8Lb2FA==
Message-ID: <c1210724-66e1-479d-958b-3e777b1266df@collabora.com>
Date:   Thu, 23 Nov 2023 10:14:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Mark VME subsystem as orphan
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Soumya Negi <soumya.negi97@gmail.com>,
        Alexon Oliveira <alexondunkan@gmail.com>,
        Matt Jan <zoo868e@gmail.com>,
        Jonathan Bergh <bergh.jonathan@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <20231123083406.12129-2-bagasdotme@gmail.com>
From:   Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20231123083406.12129-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2023 08:34, Bagas Sanjaya wrote:
> Martyn Welch lost his access to VME hardware [1]; and Manohar Vanga has been
> MIA since early January 2014 (his last message was [2]). Martyn admitted
> that the subsystem is basically orphan, so mark it as such. As a bonus,
> add CREDITS entries for the former subsystem maintainers.

Acked-by: Martyn Welch <martyn@welchs.me.uk>

> Link: https://lore.kernel.org/r/fe8ac0db-d6cc-41bc-b926-484b418e1720@collabora.com/ [1]
> Link: https://lore.kernel.org/r/CAEktxaFL=3cmU4vZS2akiAR2vG-3d+9HwTZvBvf5JXuThHoOKg@mail.gmail.com/ [2]
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v1 [3]:
>
>   * Orphanize the subsystem (Martyn)
>   * Sort Manohar's CREDITS entry
>
> [3]: https://lore.kernel.org/linux-staging/20231122094156.30642-1-bagasdotme@gmail.com/
>
>   CREDITS     | 8 ++++++++
>   MAINTAINERS | 5 +----
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index f33a33fd237170..ba6eb6274f8bed 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3916,6 +3916,10 @@ S: 21513 Conradia Ct
>   S: Cupertino, CA 95014
>   S: USA
>   
> +N: Manohar Vanga
> +E: manohar.vanga@gmail.com
> +D: VME subsystem maintainer
> +
>   N: Thibaut Varène
>   E: hacks+kernel@slashdirt.org
>   W: http://hacks.slashdirt.org/
> @@ -4016,6 +4020,10 @@ D: Fixes for the NE/2-driver
>   D: Miscellaneous MCA-support
>   D: Cleanup of the Config-files
>   
> +N: Martyn Welch
> +E: martyn@welchs.me.uk
> +D: VME subsystem maintainer
> +
>   N: Matt Welsh
>   E: mdw@metalab.unc.edu
>   W: http://www.cs.berkeley.edu/~mdw
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af7951..ff083d12001489 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23234,11 +23234,8 @@ F:	include/linux/vmalloc.h
>   F:	mm/vmalloc.c
>   
>   VME SUBSYSTEM
> -M:	Martyn Welch <martyn@welchs.me.uk>
> -M:	Manohar Vanga <manohar.vanga@gmail.com>
> -M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   L:	linux-kernel@vger.kernel.org
> -S:	Odd fixes
> +S:	Orphan
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>   F:	Documentation/driver-api/vme.rst
>   F:	drivers/staging/vme_user/
>
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
