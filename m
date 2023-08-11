Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAA7794FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjHKQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjHKQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B72D7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B8E6770E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77881C433C9;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772307;
        bh=C7Jj1OYs6Y8ePVr76OLB+L8bIX2PABmv5jP8mSCN/+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aDxQYhdJvksycHSSIEP6s94vtxONMEpCmTbr3+7RZGVIp+577Pk+h0q8rEH1ee/oI
         aq8WMtOcKMA0Lp3QOAJhYNjnMvXUIqn+GEcPciZmQSOGW6g1oxLWy2Hw7OKB9VJSKr
         CnBURV8x3OmNBam5cVo+B4JKpHkPFrvqfjw/eyrJ3OnJJRorKrV0JCCCF9BhGUW9vB
         RSihggHX/44hsTKVJsjvjIqmSNmnxK7xOcYS0WXvm+cVzv6cwhXSkj+Dovs7wmrzXU
         Jeg+2AT01iJZbbARhTcgVBlwn4ysQjt2HY0lFObWWZqqkyWzz86Yp1PzDw4OjlvU95
         L7sAyZTnvdClA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F25DC595D0;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c2fd272b-44d6-4174-9b97-3a253656e4ce@palmer-ri-x1c9>
References: <mhng-c2fd272b-44d6-4174-9b97-3a253656e4ce@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-c2fd272b-44d6-4174-9b97-3a253656e4ce@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc6
X-PR-Tracked-Commit-Id: 7e3811521dc3934e2ecae8458676fc4a1f62bf9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a3c17edbf53816ba61746c38833b48c73ee2a16
Message-Id: <169177230738.3076.11356899040172338992.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 16:45:07 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 08:41:34 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a3c17edbf53816ba61746c38833b48c73ee2a16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
