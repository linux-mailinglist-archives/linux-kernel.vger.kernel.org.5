Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB0778E0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjH3Ucw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbjH3Ucj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1345BAD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC0A664E24
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45422C433CA;
        Wed, 30 Aug 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693423824;
        bh=hWgKNG0y8QMexG14zFW4E0JCtsUQ/XYKJ1aubvC0/IQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kby8VruMcq5mcPjR1TRELI+KlX3NhrQ0nOHGVovcVNBHW6jrmbbKAioCwKRD4wXbP
         J6FGFgjhvFPdwLxpZ6Lepbfj3a6bqXuhglGpmZbNm3Nq6kgA2yeyh1UlHnZw7zmzui
         VXdtQJAUEOBEBtifBdh3oG6rNOgoil6KviFYW94QwU0FBY3zkeSDHAHjdlPvMAknzG
         XemwrGqIFnEp3uoe/jtzQI5mAcC+BZC9/ywcA/im7XL+0K1Jn7PhIaXl2HcurMoGHC
         yVd1Vg4/LwqWHQyXKi8wuMs9+4Hkh0pOd9L7gqtoygDIpBQ3ovhiXlDoAOmCrFffo/
         7LbRjs0V50Mfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26B31C64457;
        Wed, 30 Aug 2023 19:30:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830173232.2520518-1-dave.hansen@linux.intel.com>
References: <20230830173232.2520518-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830173232.2520518-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.6-rc1
X-PR-Tracked-Commit-Id: f8542a55499a69a859c84866b66f0df43933e563
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1687d8aca5488674686eb46bf49d1d908b2672a1
Message-Id: <169342382409.1414.7820049022592614287.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:30:24 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 10:32:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1687d8aca5488674686eb46bf49d1d908b2672a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
