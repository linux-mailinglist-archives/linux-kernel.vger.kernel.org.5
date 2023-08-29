Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5E78BC78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjH2Brr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjH2BrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE0184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 110506142D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6939BC433C8;
        Tue, 29 Aug 2023 01:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693273623;
        bh=w/1in/SuvVBiDrDDSzO/VSGRfEJeNzrCBRdC2XUd7kk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j0t99os5XcVBkxnJNDV/StiwY6pRQjg9Zpg7UbtFJ3wAkwjytmP9bD0FgwyPZWaQn
         Gx59abtsTNJMChrHFa9rB3GV2le68MviLj3sQ8T4cNkOPHmIXL6Io8ahLAx6zsnX8W
         nq26I57C10Q7j4q8wzF33V5SP4zHh75s07reZmNncfSfh6DIRGUnJPNOMowv+9e9Ye
         5T/YZgom7CqfJUQhfTz24kxb+gZGEuu/qlC3/MSPpN3AbEzf+LBEnV5e/kelXvPD/6
         8QOjVxMqDaWB9f5tEZek2qXWXu/czWgtjGrET4n5qCIrB2K0o1f7u5EwKmq4AkAe/J
         +SJpMaVc7evAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55BF9C3274C;
        Tue, 29 Aug 2023 01:47:03 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOwZVavwRm6PlsXG@google.com>
References: <ZOwZVavwRm6PlsXG@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZOwZVavwRm6PlsXG@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.6
X-PR-Tracked-Commit-Id: 0820debb7d489e9eb1f68b7bb69e6ae210699b3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 670f08971c0635275b25756a25a5d0b8d1831536
Message-Id: <169327362334.21367.9298825278649488004.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 01:47:03 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:49:41 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/670f08971c0635275b25756a25a5d0b8d1831536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
