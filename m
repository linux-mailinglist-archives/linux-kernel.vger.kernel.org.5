Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63F7DC365
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjJ3Xum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjJ3XuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9211C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B2DFC4936D;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709808;
        bh=irZe5KWk1s3P79P4JNKsCHC/j/zf+VobVJ+NJCKBik4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s8aIy5eGmb9MtaOdW0wCIyLipmFSBlWBl1BrvmWLgr/aeIIpQTfsq0dyYzjPskgCr
         qAokD1WYJd4CfHbFo9paYcnA0Gw3LhkBIOZunJBEinwYQQgyRB+V5OkfhtHvgrfzwG
         o+STRAckDLfYXQ5j8vcoxAmZfRl23Xo4dKwpB2/mWf499OY7lyoGiCt9Csew+0giiT
         RAxfP+npjBQVsVg355A0huRaWyP7rrFJMFaFy9aA0RPgR6Xh4tUZYXNxCZXe92GILE
         eruYNcjNGn1dtcr2Cj2SJzjWDsaC/5qzddFYJPVd50IMgKw5ZNvU39L8LvHtQ2+2Fm
         fniOnSRlIgb1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 391F2C595D7;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTzwTaf1iTnCHwJM@gmail.com>
References: <ZTzwTaf1iTnCHwJM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTzwTaf1iTnCHwJM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-10-28
X-PR-Tracked-Commit-Id: c73801ae4f22b390228ebf471d55668e824198b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cf3fabccb9dc821ffaec3ad6bf0cd6b278bd012
Message-Id: <169870980822.17163.13992032762580104413.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 13:28:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cf3fabccb9dc821ffaec3ad6bf0cd6b278bd012

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
