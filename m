Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487DA79093D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjIBSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjIBSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88210DD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2275C60023
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E8B6C433C9;
        Sat,  2 Sep 2023 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693680504;
        bh=bJ1DoYefGqK/QTL3/giXFtwnxmFkxK+NMXtrXkR4RFk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xvf9eYFRqAN7+znqnkTN9U7QMcERF38iQpNmyL5wjber7jIx2LizZG9YGmnp1zwVW
         ThimKCveg6Ue8QeOEocZKV3iAR4PKd5EsD0QYWAl7nn/ogboXGOfJJWeZejXgdz3UL
         g5hh5GDp2K/1clLRrmL8ykCS3w5PeY/xpK0bnlnkwioS2ZmHlBhzuQV/Al1v4nH2uR
         LLnAxiU5oM9EFNgnri4ouR80U6Efp0ButsYmv9flvTlYebu6QDuDgfH45XnDC/qOM6
         nurS8xQRUWX5WZsuVyD+s4B0+Kfg+9C+aY+VYiuziLk0tybru2beriztwcqLmS2c5x
         IjlnlgnOHHAaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AA75E26D49;
        Sat,  2 Sep 2023 18:48:24 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230902101034.907ddc22407d9117e432e28c@kernel.org>
References: <20230902101034.907ddc22407d9117e432e28c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230902101034.907ddc22407d9117e432e28c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.6
X-PR-Tracked-Commit-Id: a2439a4c90856b83657aec4600c19551aa9501ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b70100f2e62aeec2087d7690e41f7d6afd445f5a
Message-Id: <169368050436.9288.6945590654517202968.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 18:48:24 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Sep 2023 10:10:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b70100f2e62aeec2087d7690e41f7d6afd445f5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
