Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037579B656
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjIKUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242687AbjIKQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:07:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437A1B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:07:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD8FC433CA;
        Mon, 11 Sep 2023 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694448433;
        bh=tmX2pVfVNI/+1kYGhGjNbTdmCPLP9KsEEtgDj6OGzTc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cYEKcVUcXtLchc89h1zMTm7bx/jEQFjR8mRaNRm3NOWZbYbdiY3DpRQQatuYATHH7
         v/6XeGAcgmBUfUcpmFBu50EaUsZ5BVfpBSwxnUAeQ5dOSl6swrfWBGXWz4hpuBKSBy
         7PnKyAREgRRaqw8ajGa9+jwmoror6gIw7H35YFT/+/JzGAjbQAJ3kWVQWMrnWi9Jdj
         T5Nzj4baIXtTGCNMy+nQfy5pOoFGYIJXvHgbs1K4fjX2s4/DhjCt6a/vOayaRO8dRi
         y3wimlY6tdJm9dOsSfz5W9Y8RhuBLoK7b7NL6YoXv+qvldLaVwu5L9NluAOoqLPlMl
         WPq06TYjLOB/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A516E1C281;
        Mon, 11 Sep 2023 16:07:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2 (try 2)
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169444843310.24126.17288767595067619083.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 16:07:13 +0000
References: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
In-Reply-To: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

This pull request was applied to riscv/linux.git (for-next)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 09 Sep 2023 07:25:43 -0700 (PDT) you wrote:
> merged tag 'riscv-for-linus-6.6-mw1'
> The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:
> 
>   Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.6 Merge Window, Part 2 (try 2)
    https://git.kernel.org/riscv/c/1b37a0a2d46f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


