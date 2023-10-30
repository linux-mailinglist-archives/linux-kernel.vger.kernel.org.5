Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5771B7DC360
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjJ3XvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjJ3XuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE211A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335A8C433BD;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709808;
        bh=2wbE3y9BQNnyS0NVZ3eZ51yz8TBrm8ZQp2GyxWtdd00=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=juLLgGGG2miXpsay7vTavHU+kMfOAKqO5gmh3ofPkP/9/gYXuGpXAN3P9MPThGfX2
         FYM581SHAZmgpbiGC8K8PyI5ArOA7v+uMEkykLTA/lE9612qx4E94AVBiXgMzho6/c
         0axRZZ/76pZf09Wu8fuhRHXkz30HKRLT+3v4kE+7gbTF2QUfXi5JAieckXwPob0avW
         LlmjymVqlZm58Nk2r7pU8m//cGDw4UEHd6gcWw/tXCtKIPEYsS2AW4hPAxGIQB6Lrp
         Y8l+XTl2W4KWJypt6kyiin2JRdsBsYMMCwxR1eVbhFMT8m2o+auRd9ISsIBw6marx7
         OzC6OggkyZFow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23283EAB08B;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028085759.GAZTzNFwTVps6lLNZO@fat_crate.local>
References: <20231028085759.GAZTzNFwTVps6lLNZO@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028085759.GAZTzNFwTVps6lLNZO@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.7_rc1
X-PR-Tracked-Commit-Id: 90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cda4eb04a68aee4d795438917a4e958b2b2aa07
Message-Id: <169870980813.17163.5745749340753627478.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:08 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 10:57:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cda4eb04a68aee4d795438917a4e958b2b2aa07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
