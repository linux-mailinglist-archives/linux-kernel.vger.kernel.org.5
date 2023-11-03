Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B657E09B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbjKCTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378003AbjKCTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA396D4E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:53:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AEB7C433C7;
        Fri,  3 Nov 2023 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041206;
        bh=Bzmt/9PkOSBp4nrx0wa/BGCPGi/tuYfsR0OXghebft0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cFy12ujCoK+EKb2OT86jifH/OXYgbiCfo54XpFpTIDpTBlYNnjPG350nHMT5j57aS
         V5H4r1+GcV++0lEguWXrJo/Kkf4PAP0Fk6rb+P6ZBr7zqNVdS1fML1W4v4n6OAZgCZ
         fgqsXq8QXz2UyW2EbNkz2fU9bnSf5WE6ZhyIFM+zbJSBoErJRU4jL22a+Yui+mJb6z
         EO7Mx9ks1i1OP5e7yxJcQVxDs0n8es1aOpyx3DrpKjKBvh/JJqjpfvWf+oqNUGUXvp
         pHVEExc7hXmSPmNZECHbrqd09DnUqdujcEWpqiM0unTit3CMovhZvUqOeZNwjNkWK1
         qI2TavHg3KSKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6911FEAB08A;
        Fri,  3 Nov 2023 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] tracing tools: Updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101171001.165c13f0@gandalf.local.home>
References: <20231101171001.165c13f0@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101171001.165c13f0@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.7
X-PR-Tracked-Commit-Id: 696444a544ecd6d62c1edc89516b376cefb28929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd912e49986aa7ec5bef1bc9cd92d7d68a57e383
Message-Id: <169904120642.17286.7997963149877564189.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:26 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 17:10:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd912e49986aa7ec5bef1bc9cd92d7d68a57e383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
