Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4630781937
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHSLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHSLGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6EFE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 04:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7026111A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2F23C433C8;
        Sat, 19 Aug 2023 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692443138;
        bh=sfaxq0xo6qbtWgdwjdtQDAtyUROlam4v4nZnT+Rxb/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZMgK13YY6uUjef2SC7hEc6djcTZi288GzfYc6yW2kVl2QuemJIjxjGNLryOLxWOMf
         0nvMBfoTWIpn4eq7G7GrH/Rdo7rWkX5Ld+WlzhDSQRVUlzRqjRwQBmirJX5ETZ+y4e
         JWQLWTA2X3h+ql6nX3R02D5yfrCsAQZAOzWH6kxOAbo1SX2eDbHfqBkLo5TClthVVl
         lbDiIsvq9y5+kr4mUZ7Fl/thUfl7sPEqUEs6aBydLLK3V6AIFd7cJWi0lGaFT5WyQp
         74KK6fattNTxJsC+flRWU/YtIA2gGQ+4HnCNvsJi7dGAAc7tbvIsFOAlhOuG8e250H
         YKSZbU4BXlLDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADD2DC59A4C;
        Sat, 19 Aug 2023 11:05:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230819082709.GAZOB83cQ687HkbMgt@fat_crate.local>
References: <20230819082709.GAZOB83cQ687HkbMgt@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230819082709.GAZOB83cQ687HkbMgt@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc7
X-PR-Tracked-Commit-Id: 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf98bae3d8a18745e54fef9fd71fd129f6e9f7e5
Message-Id: <169244313870.8963.18129697725892062250.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 11:05:38 +0000
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

The pull request you sent on Sat, 19 Aug 2023 10:27:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf98bae3d8a18745e54fef9fd71fd129f6e9f7e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
