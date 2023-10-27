Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCCD7D999F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjJ0NUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDB1AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61E81C43397;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=hr3/COcgEw+89OqrvziCdCmvz2DT31kmq5qDZAF6bjs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BnfQyt8ZK4tvIVAVFVhZHSAraYk1Zot+yRpqUX7Jy3AxDYSCEA+eYd7tdxcXbbGD7
         j8zbjUAuyzTjd2tsFn5lhQEBydWwVQGG8+Fw3Xjvgb7g93G2oIJunjX65Gw27cYc56
         gf9zIa59kjnZ2XothHO7G//sVoPMar3OIs3QHTWuVeNz/Yxsn9BWkuIR/eR/wwTW6l
         Ypcu09wTIPjO73Y6WWQ8bswO6I3L8aJUeYv9yxT/MQcaSiHIjqgQXnFf+qUvMrnnA0
         9y/XP32t+acU1flFyrlRxJ1PSrEDJqH8NSQZ9wlNMm5qlz6l+FDtZv7b0o13QgQseK
         OJ7HmrFXIWRcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EDFAE1C280;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282925.15670.8161471949460416104.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, guoren@kernel.org,
        samuel@sholland.org, rppt@kernel.org, suagrfillet@gmail.com,
        panqinglin2020@iscas.ac.cn, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  9 Aug 2023 11:10:23 +0800 you wrote:
> From: Song Shuai <suagrfillet@gmail.com>
> 
> Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
> the comment of CONFIG_PAGE_OFFSET should be updated too.
> 
> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> 
> [...]

Here is the summary with links:
  - riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
    https://git.kernel.org/riscv/c/d42469b616b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


