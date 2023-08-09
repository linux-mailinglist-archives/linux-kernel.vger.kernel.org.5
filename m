Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E47776241
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHIOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjHIOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2910F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16833636B7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78D23C433CA;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590823;
        bh=O0rRZ32GVcSKvRM2KTgzM/YYRtGsLSzWH9sdjJfz7XI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EJih7LO5UhZngP0/E5robKbVAdMZ+Z9rzYQi0A9zJ8a5Qqo7K/q0eZXzIAmgRFh0x
         03Ryk0IGcVqaUToe2rZ9pHkICg5hdPp1OGFhnd0QhKNsCgoZg8Gj++TALiG/4dTBMF
         ufJj5HQaLLs+2y8QwVPSarXVXdZkZxRbh84qjS66yfrgAlU/btnpqKUgdX507ShloV
         aIZ625vjAQuImR2p5Ecw1LU7MID47gLczFfnIJf+/LYoPQpyArbXT54F/rrXwbiXou
         acQuz2jgdWzSwrXw3Qsn43qYSe0/pvDImeaLlsWNny1MMKdI1oZcX/xqXW3SGmycLD
         KeaaBe//N776A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CECE505D5;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: alternatives: fix a typo in comment
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159082339.5601.10657957305641502200.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:20:23 +0000
References: <20230723165155.4896-1-tanyuan@tinylab.org>
In-Reply-To: <20230723165155.4896-1-tanyuan@tinylab.org>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        vincent.chen@sifive.com, linux-kernel@vger.kernel.org,
        falcon@tinylab.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jul 2023 00:51:55 +0800 you wrote:
> In the usage of ALTERNATIVE, "always" is misspelled as "alwyas".
> 
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: alternatives: fix a typo in comment
    https://git.kernel.org/riscv/c/174e8ac0272d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


