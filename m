Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA17D999D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbjJ0NUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B118F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C410C43391;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=qEKw/Y2AzLwmYfm5Vuvf7oni+0lQ4DZ97GUlb04S+sY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iPbBZtX8dVhhu+6fzetSa+hXAMeEmteQC1Lb6O5GwXqzRFkRMBA24C+l2fNUFEnau
         mcd0vK93XFEQ5YYgE8lDfscZaiUov7ZPS9ZYHBekX5/3vtkrYmfJTe4kAklWgL1mbo
         vN+JZQM20Tzwgq8Tlu49mXMcyNK0I2NZwrWmw5gkqRkghVCULvnGc1kaLkb+bSNnTw
         S/ZQIEhe3yLFRyXRkDD+0jx5Hx1hOuX+h0n5bgvieHdCu3xLTRd7T7IDA5yOV92h1f
         Trfk2gQKJptXB2qB91j8p5SSgBwXZqQF6YghK3pnX6XFYIlesIVgW5ULoqZUhHqqM6
         FVHwEpg4RkK9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3767EE19E22;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Misc RISC-V timer driver improvements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282922.15670.7049548367508629850.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20230710131902.1459180-1-apatel@ventanamicro.com>
In-Reply-To: <20230710131902.1459180-1-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, anup@brainfault.org,
        linux-kernel@vger.kernel.org, conor@kernel.org,
        atishp@atishpatra.org, ajones@ventanamicro.com
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Jul 2023 18:49:00 +0530 you wrote:
> This series does two improvements to the RISC-V timer driver:
> 1) Keep timer interrupt enable state in-sync with interrupt subsystem
> 2) Increase rating of clock event device when Sstc is available
> 
> These patches can also be found in the riscv_timer_imp_v1 branch at:
> https://github.com/avpatel/linux.git
> 
> [...]

Here is the summary with links:
  - [1/2] clocksource: timer-riscv: Don't enable/disable timer interrupt
    https://git.kernel.org/riscv/c/d39d86e3e78b
  - [2/2] clocksource: timer-riscv: Increase rating of clock_event_device for Sstc
    https://git.kernel.org/riscv/c/fde893ef7084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


