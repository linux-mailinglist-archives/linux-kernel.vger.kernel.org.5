Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D96766950
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjG1Ju0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjG1JuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:50:14 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02E22D5D;
        Fri, 28 Jul 2023 02:50:05 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qPK6l-0004gg-00; Fri, 28 Jul 2023 11:50:03 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4BE39C01D2; Fri, 28 Jul 2023 11:49:07 +0200 (CEST)
Date:   Fri, 28 Jul 2023 11:49:07 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MIPS: loongson32: Remove obsolete header files
Message-ID: <ZMOPE0vVda+RPJMx@alpha.franken.de>
References: <20230726125131.462257-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726125131.462257-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:51:29PM +0800, Keguang Zhang wrote:
> No one is using regs-clk.h and regs-rtc.h.
> Therefore, remove these obsolete header files.
> 
> Changelog
> V1 -> V2: fix the build error of "‘LS1X_RTC_CTRL’ undeclared"
> 
> Keguang Zhang (2):
>   MIPS: loongson32: Remove regs-clk.h
>   MIPS: loongson32: Remove regs-rtc.h
> 
>  .../include/asm/mach-loongson32/loongson1.h   |  2 -
>  .../include/asm/mach-loongson32/regs-clk.h    | 81 -------------------
>  .../include/asm/mach-loongson32/regs-rtc.h    | 19 -----
>  arch/mips/loongson32/common/platform.c        |  8 --
>  4 files changed, 110 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
