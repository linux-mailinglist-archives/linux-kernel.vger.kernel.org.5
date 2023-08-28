Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28678BB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjH1XK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjH1XKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB113E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB26E647DB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 292E2C433CC;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693264233;
        bh=8ywCsxpw2NRrx9q+qZJFfU7FJ/k7SNOIspS8Y6Dvug4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aTVP+RvNcw+svnukevPPqKrhwiHFSZbyWVuIefJv/iG+WcKK90SqgXRhizp5yCU+V
         QvHUgYad9r/c7gNmV/ignmmDPRn9L4OJ90riK/BaVz63+jiJRe6474CdecVADcC5Fw
         DGpnwBNVHCoa2mOLRdQ31wn60MVPRyzXCMbm/14ue7be7bprBMOXmM4vNM2CbC4uZh
         6A59D33DDHaAIBrqY/cKNfiQ8iPo+MVVH3cKgwY9v7GTtqPSr+cqhwF3ETaNveVJx9
         mGS4YpWfifSSopf19dpkOCkwqsp/T81ZWj79+AC4HCoEGb4lkPhbgFjd1OYPfHnRWL
         AFh15qHVLCguw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15071E26D49;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828055239.GCZOw2J+mTIHZIDkQ/@fat_crate.local>
References: <20230828055239.GCZOw2J+mTIHZIDkQ/@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828055239.GCZOw2J+mTIHZIDkQ/@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.6_rc1
X-PR-Tracked-Commit-Id: 4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28c59d94211934bc8a030222ee7c5e9147b733f6
Message-Id: <169326423308.4748.5847972949188537437.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 23:10:33 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 07:52:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.6_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28c59d94211934bc8a030222ee7c5e9147b733f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
