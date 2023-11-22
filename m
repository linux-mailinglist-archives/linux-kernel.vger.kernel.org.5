Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947D7F44C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjKVLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:17:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88664B9;
        Wed, 22 Nov 2023 03:17:53 -0800 (PST)
Received: from [100.92.221.145] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F7206607365;
        Wed, 22 Nov 2023 11:17:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700651872;
        bh=eAylIrMyPMpSf32D9VET8qh4NyOsF2ZU2UW6TalmiHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iYBunf1OpYRul8oqUcK43Q7H/0GKMxXd4JWCJ9POWUxZWrfidKd6+D2Xx2DSYUSiv
         j04frxYbY1dzSwuyF/1iZZOM86pKMieZftOqkOAOtEPlpLubkK7zDT31JK0ZIRlp4p
         rhBMOfmFM1oL5hgqv7vgPp5YSaPJsGbBPArTp1lMSYCSq7ZD0MJUC1G2W/YU9bMxzG
         6AFNJs6p1tWO881dD5tujGDCxckUlfQZ0QK2hK+eV+gjmwo2412X5baLLfluR/gezJ
         7HkdYzOe7SK2cFePkNVA0AoOlpiRKUAK2iAfkDfYW3jJ6nNonTNsBSbeNmNNhpHlJL
         anKiuKZFAkbjg==
Message-ID: <fe8ac0db-d6cc-41bc-b926-484b418e1720@collabora.com>
Date:   Wed, 22 Nov 2023 11:17:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Update Martyn Welch's address
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <20231122094156.30642-1-bagasdotme@gmail.com>
 <20231122094156.30642-2-bagasdotme@gmail.com>
From:   Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20231122094156.30642-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 22/11/2023 09:41, Bagas Sanjaya wrote:
> He is now active on the mailing lists using his Collabora
> (@collabora.com) address. Reflect it in MAINTAINERS and also
> add address mapping for him.

Hmm, mapping yes, changing the email assigned to the VME stuff, no. This 
is not something that I consider related to my work at Collabora. Any 
time spent on it at this point will be personal time, hence the use of 
my non-work email address.

Realistically, I've lost access to hardware to test anything regarding 
VME and it's not something that's particularly easy to acquire. With the 
other patch in this series removing Manohar, removing me as a maintainer 
would leave Greg, who has been amazing covering my shoddy maintenance of 
this subsystem (what can I say, life has rather got in the way), but I 
feel it's unfair to leave him as the sole maintainer. I wonder whether 
I/we should admit this is basically orphaned at this point?


Martyn

> Cc: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Martyn, if you still had like to maintain VME subsystem, please let us know.
>
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 43031441b2d922..1df03996c73bdf 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -368,6 +368,7 @@ Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
>   Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
>   Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
>   Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
> +Martyn Welch <martyn.welch@collabora.com> <martyn.welch@collabora.co.uk> <martyn@welchs.me.uk>
>   Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
>   Mathieu Othacehe <m.othacehe@gmail.com>
>   Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af7951..a02aa52fabe14b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23234,7 +23234,7 @@ F:	include/linux/vmalloc.h
>   F:	mm/vmalloc.c
>   
>   VME SUBSYSTEM
> -M:	Martyn Welch <martyn@welchs.me.uk>
> +M:	Martyn Welch <martyn.welch@collabora.com>
>   M:	Manohar Vanga <manohar.vanga@gmail.com>
>   M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   L:	linux-kernel@vger.kernel.org
