Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D17E8DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjKLAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjKLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC930FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:55:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68ACAC433C9;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=VgTVM+5WP2BDA8+eWnnrND2B8DSs8IWm3pfXn96hH5M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JLb3QwkYkbpfY3FNvlq0ln90cjF2dCJ/FBjoJvohtlKl5++jjxUpLiRvVRrzLfnMw
         vqIx6cIMfKr070kpufEO4pDDNYZBrsbey74LmD56VyB6rtMKEMS2PuHv8FlOzAdnko
         OCS/Hdjzh6S+iL7nZNY1du7wFsPrQPCaydb5KK9mUDp8BLAfADd2autchrBUsE5bXS
         wtlaPjOEbe6qAkDlAIfra6VZWq2xAq3pay7+/5hPxAYOmrUCJZap1/rY5guetPn+MO
         WzYBiUUdpnzpd6S0tZndmFihAyu/lQnh1zU4pQRpK3GfZZ53EnlYT1MgSfx2vEGWUx
         pSeNNz6aY733A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4447AE00088;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] kbuild: remove ARCH_POSTLINK from module builds
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054627.11360.14371365860315312701.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20231017103742.130927-1-masahiroy@kernel.org>
In-Reply-To: <20231017103742.130927-1-masahiroy@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, bp@alien8.de,
        christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mpe@ellerman.id.au,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        nicolas@fjasle.eu, palmer@dabbelt.com, paul.walmsley@sifive.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Masahiro Yamada <masahiroy@kernel.org>:

On Tue, 17 Oct 2023 19:37:39 +0900 you wrote:
> The '%.ko' rule in arch/*/Makefile.postlink does nothing but call the
> 'true' command.
> 
> Remove the meaningless code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> [...]

Here is the summary with links:
  - [1/4] kbuild: remove ARCH_POSTLINK from module builds
    https://git.kernel.org/riscv/c/7f6d8f7e43fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


