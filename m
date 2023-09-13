Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199E79DD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjIMAhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIMAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800F1708
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CD9BC433C9;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694565420;
        bh=HgcPYkQCEMqwS01o+/ylolT9Zi+5eZaHSwKnIn092ag=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nDGWSfho1BlquLhL+yWTOKYwVYqxwdyDAURH+0HnGN7Ql2S7nnNpmPRho9YUqSxDl
         wFxO5Dhk2Buhn4HkSmEQe3hm4ufeKjPA5ONZrOnejFJ9vz4goh4dAbejMxEP0jggrl
         aCkrNDsoZ+jQbmLKnKLmnb8W3cBEtzMJYME22/vpClhN8rEuprCFxWSqKD21u0XjjU
         AIEjEIuW/qQzpVlcWv8HtlVVVuQl5dbkt5ay5vH66PrDQyR/BX/KGcKz2b6xkwhY+8
         ZqYVfKJAUDYGMc8hygXAH1BGnWjjV6j+SHikSfR06+x1vmiErnqcy9m/jPI454/cpE
         8Gtrpq3GAhW8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2168BE1C282;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: kexec: Align the kexeced kernel entry
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169456542013.30716.9158601549505953112.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Sep 2023 00:37:00 +0000
References: <20230906095817.364390-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230906095817.364390-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        lizhengyu3@huawei.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  6 Sep 2023 17:58:17 +0800 you wrote:
> The current riscv boot protocol requires 2MB alignment for RV64
> and 4MB alignment for RV32.
> 
> In KEXEC_FILE path, the elf_find_pbase() function should align
> the kexeced kernel entry according to the requirement, otherwise
> the kexeced kernel would silently BUG at the setup_vm().
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: kexec: Align the kexeced kernel entry
    https://git.kernel.org/riscv/c/1bfb2b618d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


