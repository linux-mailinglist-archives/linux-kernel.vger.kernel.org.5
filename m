Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EE7C77FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442748AbjJLUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347401AbjJLUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E09D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48207C433CC;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143225;
        bh=Jn75P7FWp8mm9c9ThH2hJ5ALb5bEA3ARYqgsn3M7Pnk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lJyIT3lAAVqJiqz3p5FH9Yy4pjyq++odnmtzc98c/WDd2cSz0NfBH/BbtLhPPLyYv
         //D6SDbYlOuUWMazQaZn3/70kUJ+7dkwownnNkRXkTZYpyNBxMl/dSu3aQOq1gJ6nt
         TKFUM9DC8A5BIirvxf6nFMdIRXxBVlQrqYZY5oCOWy6f48VTjb1FmBVAu7cRtfLLyC
         tvFcaIntT58cT29J4tMQkXQAcqMaK8nfw1E+n41Hzs5N0D0Ah5nlKMKqDis+wcCnGD
         Qq5jMfrEp3LuToHcwhJeWpuHc/LJL2NjSU2LOiGKPbSj8qlxsKvVWSux3nsTHqTzGS
         DjYBWORtYqZIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B05BE21EC2;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Remove duplicate objcopy flag
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169714322517.23371.9305452183998356720.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 20:40:25 +0000
References: <20230914091334.1458542-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230914091334.1458542-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 14 Sep 2023 17:13:34 +0800 you wrote:
> There are two duplicate `-O binary` flags when objcopying from vmlinux
> to Image/xipImage.
> 
> RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
> Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
> in Kbuild would join them together.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Remove duplicate objcopy flag
    https://git.kernel.org/riscv/c/505b02957e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


