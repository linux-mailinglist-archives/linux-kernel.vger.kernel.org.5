Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0486379DD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjIMAhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbjIMAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED44170A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A6BC433CA;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694565420;
        bh=QLIbIliIzoX8mYCbj7k2VtC9RtEwWULaWzil7YqJrF4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O83Lbr9c1crtDI00vKKCCy53BfUR8hFWoh68Nl+Ee6XE4DXB8Q3MWwjO3AJE5nyTG
         g9gGjwUIyIcJ2FD6XCoThgFCCAMlPQasUkomyH6X59kaY2wWfj6esXYfh3ZFJEPdKE
         pjAE79vvCU8/3itysUiSSwdyAvhgOtTdIYR7ILnouMv7h4rrAd05r+RWgBjfIseGiF
         0ggFGO3tE4pMkcBCR0eILHg8SurdwShRvf3B7+nJRmtBS6yPO2euZuYiLH7lUyKppx
         iE54zne0PGBu4jkpnPS1ROQEkCfuB/GnPK8IeFZG2m58cnoqQPfqnKYeY1n9zBZMy1
         m1aJuiFlle8Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37F7EE49FA7;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: errata: improve T-Head CMO
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169456542022.30716.3944233771389169729.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Sep 2023 00:37:00 +0000
References: <20230827090813.1353-1-jszhang@kernel.org>
In-Reply-To: <20230827090813.1353-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 27 Aug 2023 17:08:11 +0800 you wrote:
> This is a renew of Icenowy patch series[1], patch1 is necessary to
> make T-Head C910 powered SoCs CMO work correctly. patch2 is to name
> those instructions following thead-extension-spec.
> 
> Icenowy Zheng (2):
>   riscv: errata: fix T-Head dcache.cva encoding
>   riscv: errata: prefix T-Head mnemonics with th.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: errata: fix T-Head dcache.cva encoding
    https://git.kernel.org/riscv/c/8eb8fe67e2c8
  - [v2,2/2] riscv: errata: prefix T-Head mnemonics with th.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


