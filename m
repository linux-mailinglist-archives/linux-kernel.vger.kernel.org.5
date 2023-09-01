Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE19C7900B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbjIAQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjIAQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AF10D4;
        Fri,  1 Sep 2023 09:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35913628A6;
        Fri,  1 Sep 2023 16:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A218C433C7;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=UsrWWuGhBsfObaHsj8jo58OGQiK1tUZL0wJ+nLLR09w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D2IwhzH6BD7FOaUUtbnoy/8AckypdF8yx4e5QoAr1iDtDWR2fHUdhO2LE4wGGxvws
         Gaf/CNiJe0bNBnXLe72e4qk2xwigJXT5U1t7icHwGOdOxIjinRLiqxyB+lgRjYhgem
         Vi/vKbZNN6yP+Xm7+d9Z+Gg/j/VcAJ4AUVhgTPTHSHtgI9Ejv1t928vNhvIPRISP1E
         n9xgvFCx7ifK8U1nGjPeaYrwk323HRSDT+REKySdlmqR/R5pJRcgWK6oPnel2OnZGd
         WlL/ZOmszjlVfWdNhAwh4JAeRLP00wia+Nx3a+ykamnx0p2EA4fVA7VRSvIv032Rae
         ZpfaJpwENV9/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D709E29F3C;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/3] Documentation: arm: Add bootargs to the table of added
 DT parameters
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551543.8276.13081700534673063288.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <20230817130734.10387-1-alexghiti@rivosinc.com>
In-Reply-To: <20230817130734.10387-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, bjorn@rivosinc.com, ajones@ventanamicro.com,
        conor.dooley@microchip.com, sunilvl@ventanamicro.com,
        songshuaishuai@tinylab.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Jonathan Corbet <corbet@lwn.net>:

On Thu, 17 Aug 2023 15:07:32 +0200 you wrote:
> The bootargs node is also added by the EFI stub in the function
> update_fdt(), so add it to the table.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
> 
> [...]

Here is the summary with links:
  - [v7,1/3] Documentation: arm: Add bootargs to the table of added DT parameters
    https://git.kernel.org/riscv/c/b4ba5e5eafad
  - [v7,2/3] Documentation: riscv: Add early boot document
    https://git.kernel.org/riscv/c/e79be4bea58f
  - [v7,3/3] Documentation: riscv: Update boot image header since EFI stub is supported
    https://git.kernel.org/riscv/c/180bb41d61b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


