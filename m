Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347478BAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjH1WQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjH1WPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAB129;
        Mon, 28 Aug 2023 15:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744A66178B;
        Mon, 28 Aug 2023 22:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC3ECC433C8;
        Mon, 28 Aug 2023 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260951;
        bh=vfkqjeYQjwQs+qnBGnyYwwBwu1XP4xdkEzztNGmHz10=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jL+G4+6P0BfY+iK3ELrryGZG2VxoasVT4jIyxvzdybNlCDZVEiLeayLN5sf0MRnlY
         m4GX6MGn6OTzDz1w+L8SJKECNjCneDXfVjbeM+yxLeWRbtA28YUrrPxYOqy/LwpjtS
         6/1plztCLe2PvHEl14gvQIqMi3sljfBPF0nM4BpHHUN6foAsEl4h2EPQ5u1pG0s5iK
         1GXHGYOg/z1Id6TKqpR+vgrj6QsHxnm2SwiMA38NS7/S0LhkMU0t+R40Ts+jFKfrhE
         3RKvJaskQOvbwj4llvnPY27Nz+5ZE9JCET3rtHwSVtHW04AZLgmipIC4sKSGDqk/DW
         Y14E71GAkJrgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEFF3C3959E;
        Mon, 28 Aug 2023 22:15:51 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <222d7653-b6c8-4132-863d-94c04c781f1d@paulmck-laptop>
References: <222d7653-b6c8-4132-863d-94c04c781f1d@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <222d7653-b6c8-4132-863d-94c04c781f1d@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.08.21a
X-PR-Tracked-Commit-Id: fe24a0b63278808013e1756e235e0e17e8bae281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68cadad11fe2ddd126b37a8fba3726be7fa0f5c6
Message-Id: <169326095177.8741.1343363078300881244.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:51 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rcu@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 14:58:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.08.21a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68cadad11fe2ddd126b37a8fba3726be7fa0f5c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
