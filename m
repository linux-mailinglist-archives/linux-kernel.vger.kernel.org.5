Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307577DC363
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjJ3Xux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjJ3XuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEAD102
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 735F5C4167D;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709808;
        bh=w+z+AWwZSZmxcAagsGBErR0O+uiAosw6l4/Zh7U1mIw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kgopti04ZwoUuLkG2TqNgSBHRigwP1oFdg2P8YZLWDt4L9NW8fM1GYg0nlZUbX2Fx
         cykbQSPKRT85cBPeBmQszXTlzO3XNAOJWrMPgByiAWWNxCzzpeKDrD0YjJbgC5ssem
         t82+K1Ks9TyE/AYnMxhEEiciDt7COhqjDzeqDiViG2o9cQRiioj3w/20/mBSlsXjaq
         yHU+KhlsU6NtiDT0uAbW1YCOCtHucHolusPEdshSDjuTm5AM/GVwjFWL7jHWOZbV/Z
         38acPgp4990tuB8FALc3WiXoa97avbd9H/Jf+LzQntEaOZKwBFG6qTIoV9iflaLPna
         zaGYMzQ3xgwVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EE18E0008C;
        Mon, 30 Oct 2023 23:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTzyIWSElIo0KZzD@gmail.com>
References: <ZTzyIWSElIo0KZzD@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTzyIWSElIo0KZzD@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-10-28
X-PR-Tracked-Commit-Id: 60fd39af33d3f63c4c94bd06784ebdf0d883f5c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd063c8b9e1e95560e90bac7816234d8b2ee2897
Message-Id: <169870980838.17163.12472974391694975542.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 13:36:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd063c8b9e1e95560e90bac7816234d8b2ee2897

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
