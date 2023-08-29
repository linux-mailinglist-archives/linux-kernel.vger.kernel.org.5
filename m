Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6F78C87E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjH2PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjH2PWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:22:00 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22DB41AA;
        Tue, 29 Aug 2023 08:21:57 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qb0XU-0001Th-00; Tue, 29 Aug 2023 17:21:56 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 50587C01A3; Tue, 29 Aug 2023 17:21:45 +0200 (CEST)
Date:   Tue, 29 Aug 2023 17:21:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: loongson32: Remove dma.h and nand.h
Message-ID: <ZO4NCXnhauFQgvfJ@alpha.franken.de>
References: <20230828134725.103442-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828134725.103442-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:47:25PM +0800, Keguang Zhang wrote:
> Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
> are unused. Then, dma.h and nand.h are useless.
> Therefore, remove these useless header files.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Remove include of dma.h and nand.h
>           Update the commit message

this still doesn't compile, when applied to mips-next. Can you
please check, that it compiles before sending ? Thank you.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
