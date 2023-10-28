Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA67DA861
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjJ1SHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1SHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:07:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686BCE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:07:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E40FCC433CB;
        Sat, 28 Oct 2023 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698516469;
        bh=H4fNS4fE6oWrdpWT7Vq8EmgmOH+p8XVbHZX7b4knU5g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=myJ+bGEHwKc04MCKtLXXCyGh8m2JvCwM1qHLbUJqnepRX+XhYDS5GwKC9yC6v4ZAX
         9/SYBN82Md4tLRehcIKYmMw3QRrOGnF6agTQecAz4YleT4rNu7wiIC8JU7+ybwcHuM
         s+yUIFdqAi9FvYSnd1mv3W/eS6hDVv6+Cer+xwXV5F1Nu51C+WKY3ZuS5ioQxv69xl
         X2YrrG73Kqpoa01hcFfH6HfhvCJdobgrzyWO3iEINy+Ekl2bH53ukZFFrvCTcz5Rlf
         TOskOrQ/vU/uOSGf90Bsf/UM2FExyRYVKZhPWbN9iD9+CLXdmZAobvNhDlUIXuSEVH
         8tgLRx+qAbBuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D08EAC00446;
        Sat, 28 Oct 2023 18:07:48 +0000 (UTC)
Subject: Re: [GIT PULL] probes: fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028190056.dde870427d845332e99e9db9@kernel.org>
References: <20231028190056.dde870427d845332e99e9db9@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028190056.dde870427d845332e99e9db9@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc7
X-PR-Tracked-Commit-Id: 926fe783c8a64b33997fec405cf1af3e61aed441
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51a7691038c334db81b736faa6b4cc4778e751fc
Message-Id: <169851646885.24400.15744133454722837633.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:07:48 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 19:00:56 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51a7691038c334db81b736faa6b4cc4778e751fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
