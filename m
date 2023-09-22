Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFB7ABC73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIVX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIVX6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:58:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C3A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:58:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62ABEC433C8;
        Fri, 22 Sep 2023 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695427087;
        bh=rq1CJtO+zGqxehd51mrZWzUoWAqcCD0w0C0UJJSzcG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p8PEdyF11I8WZLzzqT6ktJ/eIrZ0p7Xb0ntkRs83uPRDqsO5cghuTsQhdxh7/OriM
         Ed8TCK/Ze19UOsNffFa6PLAr2nmMOhPDpAeE0a1DMilZfHLQo5EI+XWpmeshcuKAt9
         CxlhRbsEgGDyoCFxYk+Vuk83P9Nr76BPO2GaJ3tgz2cwCc8eurnscad7aKcEPfXhhj
         DcdGWTzzsxOhsmWXsqPvTq2jl/U1PXct4eAjtVcS2e1TeOsc7gSza+/MWev8+aidA4
         UTjNBFeFE6UEM0aZfl7hZbwHjbj6HsVfRGW4dHYYC+F3jWivRzyxZksy813iBwIK+a
         fSm2A62X+gNiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 506BBC04DD9;
        Fri, 22 Sep 2023 23:58:07 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202309220957.927ADC0586@keescook>
References: <202309220957.927ADC0586@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202309220957.927ADC0586@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc3
X-PR-Tracked-Commit-Id: 32a4ec211d4164e667d9d0b807fadf02053cd2e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d90b0276af8f25a0b8ae081a30d1b2a61263393b
Message-Id: <169542708732.18241.6164435010628590833.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 23:58:07 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 09:59:01 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d90b0276af8f25a0b8ae081a30d1b2a61263393b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
