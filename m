Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71A7D999E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJ0NUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16818A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE13C433CC;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=uaH9oSE8hSkKDrtZ+0k6LRDnVc9OxcoK0ehE0l5U8ek=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZJsomzOASmPMdOTc2TIYX2q1MNQgkY7nBHCDWAyDyDl+kFMaSfgJitYqGJaUfRqsx
         bqE8LgStwd4vG1/+rAL1v+Q5Jnq97fW0qQTHKu0oqJdmdbLj7XgNCgzGmtNpyrY9p8
         SHZ3A5T/mpRZZe88g3U681OnxeXidQ5nZULw3jLTsd3J31dGGUzcvfrGV6L4bQxIbR
         WvgAItRJ1abxHPUKPt/YQ4lIVHMiJLwbSLBieDE6ogNmZJRoXZxsEfWfaaeVNlSTYO
         ghQKqF+5BXl9XUQSytlDYhkm/ex0PaOdyOa19ht6ZpT47bk+xCmZ7uFCAODUYq/4G8
         i92lIqCuQhTww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D0FDC41620;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 -next 0/4] RISC-V: ACPI improvements
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282911.15670.16781297228669817220.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
In-Reply-To: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, apatel@ventanamicro.com,
        aou@eecs.berkeley.edu, rafael@kernel.org,
        conor.dooley@microchip.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, ajones@ventanamicro.com, lenb@kernel.org
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

On Wed, 18 Oct 2023 18:10:03 +0530 you wrote:
> This series is a set of patches which were originally part of RFC v1 series
> [1] to add ACPI support in RISC-V interrupt controllers. Since these
> patches are independent of the interrupt controllers, creating this new
> series which helps to merge instead of waiting for big series.
> 
> This set of patches primarily adds support below ECR [2] which is approved
> by the ASWG and adds below features.
> 
> [...]

Here is the summary with links:
  - [v4,-next,1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
    https://git.kernel.org/riscv/c/e8065df5b0c4
  - [v4,-next,2/4] RISC-V: ACPI: Update the return value of acpi_get_rhct()
    https://git.kernel.org/riscv/c/a06835227280
  - [v4,-next,3/4] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
    https://git.kernel.org/riscv/c/9ca87564190c
  - [v4,-next,4/4] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
    https://git.kernel.org/riscv/c/2960f371f165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


