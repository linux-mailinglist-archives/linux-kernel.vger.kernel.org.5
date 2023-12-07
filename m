Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C8808BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443456AbjLGPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443443AbjLGPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441A110DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2790C433CA;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962425;
        bh=Nfw2DQJucK3TOTM/iXs2sHe7UkhmWINwujw5d2hDVcY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kc1j1h6Q+E2cEHA8NRkwn7UCAXjf24XB//4aiWcSySDQvTdMUGy62PP7Ft1un+vkf
         /xtRh+7Ejxp33DCRfa/XoF2ZuH4MV17MyiY9kf1GWtM8Og6vo4W1gOqsoMN4T+uYmK
         02T4ip5pd0IGbrjzBZczye97f/4RvdiujgwNiiz9ya1mFEyUuWsfZK4p+DnK1Ja4bc
         rfZw3VKIaiFHTmYXyDi6RrGXbhaFjA1Ab5ThasA+9m0IArK6sw8EHDHkI/Id/qOX22
         mXj6W/CURThZ5829KMUN6mLHKOT9SlUuZh+FbwBiLitQTjq8zSc/pRteTsTzUtPSwJ
         M3+ILH06iLO9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B83ABDD4F1D;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Support rv32 ULEB128 test
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170196242575.12999.2675447724250282686.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 15:20:25 +0000
References: <20231122-module_fixup-v2-1-dfb9565e9ea5@rivosinc.com>
In-Reply-To: <20231122-module_fixup-v2-1-dfb9565e9ea5@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rdunlap@infradead.org,
        re@w6rz.net, palmer@rivosinc.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 22 Nov 2023 15:35:54 -0800 you wrote:
> Use opcodes available to both rv32 and rv64 in uleb128 module linking
> test.
> 
> Fixes: af71bc194916 ("riscv: Add tests for riscv module loading")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/1d7c71ee-5742-4df4-b8ef-a2aea0a624eb@infradead.org/
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> [...]

Here is the summary with links:
  - [v2] Support rv32 ULEB128 test
    https://git.kernel.org/riscv/c/82180b1fae24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


