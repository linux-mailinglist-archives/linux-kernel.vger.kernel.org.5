Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70B278B170
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjH1NQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjH1NPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:15:34 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A78199D;
        Mon, 28 Aug 2023 06:15:30 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qac5Z-0006IL-00; Mon, 28 Aug 2023 15:15:29 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 39A89C01A3; Mon, 28 Aug 2023 15:15:17 +0200 (CEST)
Date:   Mon, 28 Aug 2023 15:15:17 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: loongson32: Remove unused dma.h and nand.h
Message-ID: <ZOyd5V+7GCfIaLi7@alpha.franken.de>
References: <20230828130223.89898-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828130223.89898-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:02:23PM +0800, Keguang Zhang wrote:
> Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> unused platform devices"), no one is using dma.h and nand.h.
> Therefore, remove these unused header files.

I don't think so:

/local/tbogendoerfer/korg/linux/arch/mips/loongson32/ls1b/board.c:11:17: fatal error: dma.h: No such file or directory
 #include <dma.h>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
