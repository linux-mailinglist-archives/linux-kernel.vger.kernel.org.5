Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B47E27F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjKFPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjKFPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E1191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B3CC433C7;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282830;
        bh=inSvyAXRWVhJKzxXGHYkYj/Xog6XFtFACxlgXU8Pmhs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P/GcyVWmubX8jMX6sQ3RvB1MPQ9k0zVhYtU7pSSJ7ZAJ+tr5boFRL0ChQW63nJ592
         F+JAmTYAKKofKS1nTNuqXjnmGUn0z9L3fBXO6CUaEfafgFscxkInlq9YAPj4MdQ1Cb
         +3uTNjo/t3+i12ndHeaCBpW3FlPrdCSvAi1icvIWbDX8bFNDL+i+d2t8DbGgizVfF3
         H8fFGXBnuYtp0/cE0juLJ3luCiyls7ugd2uvVSWCR44xG/EUi6SySTJmH9CMm1ZIpV
         jzunLfcJOdmNZciL5FuVM8Tirah7lSwk6R4F+w5W3Zvu3eJbFBRJzFZoVfQfwfCIms
         pC0x9+sYMCMfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0BB8E00087;
        Mon,  6 Nov 2023 15:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] Improve PTDUMP and introduce new fields
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282898.16503.17999232797960429532.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:28 +0000
References: <20230921025022.3989723-1-peterlin@andestech.com>
In-Reply-To: <20230921025022.3989723-1-peterlin@andestech.com>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, david@redhat.com,
        akpm@linux-foundation.org, alexghiti@rivosinc.com,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 21 Sep 2023 10:50:19 +0800 you wrote:
> This patchset enhances PTDUMP by providing additional information
> from pagetable entries.
> 
> The first patch fixes the RSW field, while the second and third
> patches introduce the PBMT and NAPOT fields, respectively, for
> RV64 systems.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] riscv: Improve PTDUMP to show RSW with non-zero value
    https://git.kernel.org/riscv/c/d5d2c264d33b
  - [v4,2/3] riscv: Introduce PBMT field to PTDUMP
    https://git.kernel.org/riscv/c/0713ff337173
  - [v4,3/3] riscv: Introduce NAPOT field to PTDUMP
    https://git.kernel.org/riscv/c/015c3c370472

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


