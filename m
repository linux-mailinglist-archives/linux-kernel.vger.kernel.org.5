Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6879806A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjIHCJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjIHCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152971BD9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:09:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21316C433C7;
        Fri,  8 Sep 2023 02:09:13 +0000 (UTC)
Message-ID: <f0682bfa-e779-499c-4c85-bf923e23383b@linux-m68k.org>
Date:   Fri, 8 Sep 2023 12:09:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] m68k: Replace GPL 2.0+ README.legal boilerplate by
 SPDX
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1694095086.git.geert@linux-m68k.org>
 <db6225d078aae61474ccbde322851758d02e94a9.1694095086.git.geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <db6225d078aae61474ccbde322851758d02e94a9.1694095086.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 8/9/23 00:21, Geert Uytterhoeven wrote:
> Upstream Linux never had a "README.legal" file, but it was present
> in early source releases of Linux/m68k.  It contained a simple copyright
> notice and a link to a version of the "COPYING" file that predated the
> addition of the "only valid GPL version is v2" clause.
> 
> Get rid of the references to non-existant files by replacing the
> boilerplate with SPDX license identifiers.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   arch/m68k/68000/entry.S     | 7 ++-----
>   arch/m68k/bvme6000/config.c | 5 +----
>   arch/m68k/coldfire/entry.S  | 7 ++-----
>   arch/m68k/ifpsp060/Makefile | 6 ++----
>   arch/m68k/kernel/entry.S    | 7 ++-----
>   arch/m68k/kernel/head.S     | 8 ++------
>   arch/m68k/mvme147/config.c  | 5 +----
>   arch/m68k/mvme16x/config.c  | 5 +----
>   arch/m68k/q40/config.c      | 5 +----
>   9 files changed, 14 insertions(+), 41 deletions(-)

Thank you for taking care of the ColdFire and 68000 ones as well!

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
> index 7d63e2f1555a03dc..72e95663b62ffd54 100644
> --- a/arch/m68k/68000/entry.S
> +++ b/arch/m68k/68000/entry.S
> @@ -1,12 +1,9 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
>    *  entry.S -- non-mmu 68000 interrupt and exception entry points
>    *
>    *  Copyright (C) 1991, 1992  Linus Torvalds
>    *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
> - *
>    * Linux/m68k support by Hamish Macdonald
>    */
>   
> diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
> index e604fe6602461334..8a2ee69a09f6659c 100644
> --- a/arch/m68k/bvme6000/config.c
> +++ b/arch/m68k/bvme6000/config.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    *  arch/m68k/bvme6000/config.c
>    *
> @@ -8,10 +9,6 @@
>    *  linux/amiga/config.c
>    *
>    *  Copyright (C) 1993 Hamish Macdonald
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
>    */
>   
>   #include <linux/types.h>
> diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
> index 35104c5417ff4d07..4ea08336e2fb0aae 100644
> --- a/arch/m68k/coldfire/entry.S
> +++ b/arch/m68k/coldfire/entry.S
> @@ -1,4 +1,5 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
>    *  entry.S  -- interrupt and exception processing for ColdFire
>    *
>    *  Copyright (C) 1999-2007, Greg Ungerer (gerg@snapgear.com)
> @@ -13,10 +14,6 @@
>    *
>    *  Copyright (C) 1991, 1992  Linus Torvalds
>    *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
> - *
>    * Linux/m68k support by Hamish Macdonald
>    *
>    * 68060 fixes by Jesper Skov
> diff --git a/arch/m68k/ifpsp060/Makefile b/arch/m68k/ifpsp060/Makefile
> index 56b530a96c2f33b5..00d0621f547ccb93 100644
> --- a/arch/m68k/ifpsp060/Makefile
> +++ b/arch/m68k/ifpsp060/Makefile
> @@ -1,7 +1,5 @@
> -# Makefile for 680x0 Linux 68060 integer/floating point support package
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "README.legal" in the main directory of this archive
> -# for more details.
> +# Makefile for 680x0 Linux 68060 integer/floating point support package
>   
>   obj-y := fskeleton.o iskeleton.o os.o
> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 4dd2fd7acba9ea07..3bcdd32a6b36613d 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -1,13 +1,10 @@
> -/* -*- mode: asm -*-
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * -*- mode: asm -*-
>    *
>    *  linux/arch/m68k/kernel/entry.S
>    *
>    *  Copyright (C) 1991, 1992  Linus Torvalds
>    *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
> - *
>    * Linux/m68k support by Hamish Macdonald
>    *
>    * 68060 fixes by Jesper Skov
> diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
> index 9e812d8606be8301..852255cf60dec132 100644
> --- a/arch/m68k/kernel/head.S
> +++ b/arch/m68k/kernel/head.S
> @@ -1,4 +1,5 @@
> -/* -*- mode: asm -*-
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> +** -*- mode: asm -*-
>   **
>   ** head.S -- This file contains the initial boot code for the
>   **	     Linux/68k kernel.
> @@ -25,11 +26,6 @@
>   **            for linux-2.1.115
>   ** 1999/02/11  Richard Zidlicky: added Q40 support (initial version 99/01/01)
>   ** 2004/05/13 Kars de Jong: Finalised HP300 support
> -**
> -** This file is subject to the terms and conditions of the GNU General Public
> -** License. See the file README.legal in the main directory of this archive
> -** for more details.
> -**
>   */
>   
>   /*
> diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
> index 7dfacd0b207a9750..8b5dc07f0811f2fc 100644
> --- a/arch/m68k/mvme147/config.c
> +++ b/arch/m68k/mvme147/config.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    *  arch/m68k/mvme147/config.c
>    *
> @@ -7,10 +8,6 @@
>    * Based on:
>    *
>    *  Copyright (C) 1993 Hamish Macdonald
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
>    */
>   
>   #include <linux/types.h>
> diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
> index 9bb9a33e43c246c4..d1fbd1704d65822f 100644
> --- a/arch/m68k/mvme16x/config.c
> +++ b/arch/m68k/mvme16x/config.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    *  arch/m68k/mvme16x/config.c
>    *
> @@ -8,10 +9,6 @@
>    *  linux/amiga/config.c
>    *
>    *  Copyright (C) 1993 Hamish Macdonald
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
>    */
>   
>   #include <linux/types.h>
> diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> index 2c51c2b4a4fbbf79..de7870ad2a30620d 100644
> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    *  arch/m68k/q40/config.c
>    *
> @@ -6,10 +7,6 @@
>    * originally based on:
>    *
>    *  linux/bvme/config.c
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file README.legal in the main directory of this archive
> - * for more details.
>    */
>   
>   #include <linux/errno.h>
