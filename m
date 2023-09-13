Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D279DD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjIMAhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjIMAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78591706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 473AAC433C8;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694565420;
        bh=srKgiw1+9R9KRwICqMzY0SIrsPWn+g9Gu8eRObYiO7Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XDotN6mnkIxk5BwwtRJbhhYAc9wXZIDfi/y2pnldNwKoihG/Gny7S5Yn76/EDmxbg
         uwTooNoLcpFn+yCSO0YhGxIIkFJ1VoeMJVjgp1LbEGfcszktHmKAQx+fBHzMig6hI8
         ZRx46heOvgfjoUQS49Dqmlq41ANeV+/c6N6VYXx/fZXO5r1+xnl/fVzQ+8yFkaWPw1
         Q1U7JIyo5NSXUKkkd1xC2AzU784NYjg2rGtgbgE/OsEzNIJndsaulI15fqdTkV6M1A
         rM7OdYdPYFOGZLdQhu3tAVFLPZGUC/3E2cavirNdzcppdNtrtJJxnfFsLuiIDO5sOj
         Apa7qgZBGvaeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D3E8C04DD9;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V1 0/3] riscv: kexec: cleanup and fixups
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169456542018.30716.13506539771908013747.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Sep 2023 00:37:00 +0000
References: <20230907103304.590739-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230907103304.590739-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, lihuafei1@huawei.com,
        petr.tesarik.ext@huawei.com, duwe@suse.de, ribalda@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org, hi@alyssa.is,
        heiko@sntech.de, lizhengyu3@huawei.com, alexghiti@rivosinc.com,
        schwab@suse.de, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  7 Sep 2023 18:33:01 +0800 you wrote:
> Hi,
> 
> I had posted 2 patches [1][2] for riscv/kexec, but there was no "effective"
> response to them until now, so I merged them in this series with the 3rd fixup.
> 
> Anyway, this series contains a cleanup for riscv_kexec_relocate() and two fixups
> for KEXEC_FILE and had passed the basic kexec test in my 64bit Qemu-virt.
> 
> [...]

Here is the summary with links:
  - [V1,1/3] riscv: kexec: Cleanup riscv_kexec_relocate
    (no matching commit)
  - [V1,2/3] riscv: kexec: Align the kexeced kernel entry
    https://git.kernel.org/riscv/c/1bfb2b618d52
  - [V1,3/3] riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


