Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D63C79F253
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjIMTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjIMTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40944B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:44:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7338C433C8;
        Wed, 13 Sep 2023 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694634278;
        bh=vc5LRVrTRPJHNrgAxjAE4fu08x3I05Mn7b6KXiJP9gc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q9VKVGQo5S9MbJ4wW0zej+dRm+TqL1s1Wefc2gxKnxKm9DGw7XfhGR3CNxJ/fHQtn
         HEqD54WdxzMH4rduZygBue0WeHWn6biCwywqih91feWy+gWz9Smi36k8+2NlORtE82
         YrOfp+dcva2wkq4g1/mJb4OT+aWQG4oS3RP7AYq5bA4oH2beYxz29orFYU62EVs1KX
         Pr7nCUxTTDgMqtPMFHx//dylDlPFy2Py5bBxXnJie6lAidSRZPkW/ODif/CWsvmXz8
         i6EiUiWbqz0ft1FhWF2EA5cwl+cOqgShIqs/NwgA1Ds1b2vaEILHFZhXHk0/YBBEEa
         W9dVvz12MnOLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5AB4C64459;
        Wed, 13 Sep 2023 19:44:38 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230912144046.692c1e4d@gandalf.local.home>
References: <20230912144046.692c1e4d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230912144046.692c1e4d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc1
X-PR-Tracked-Commit-Id: c8414dab164a74bd3bb859a2d836cb537d6b9298
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99214f67784b11e98fb099201461aebe08dec3eb
Message-Id: <169463427880.14198.11146304513226335808.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Sep 2023 19:44:38 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Naveen N Rao <naveen@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Sep 2023 14:40:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99214f67784b11e98fb099201461aebe08dec3eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
