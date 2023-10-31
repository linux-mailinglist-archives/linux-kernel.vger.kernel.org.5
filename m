Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77327DC607
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjJaFnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjJaFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B81FF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F83C4E662;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730954;
        bh=DwgHstoGjAONUsexyJxiJd4hzFRFVubKTU21+tcSwdQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HlVmrgGbz6mkIOlP23GVVwWZg7tx2dqoLoBcupnXHUhh3/OrSopWAJ0DlBLI1pucC
         YZdmfhsGMbG5HEPFIHpswdaTf4baldX08scCaDo8Fyx/qoSrlC0E+M4QHlf2NAJuQf
         D70fyOm7wBZXQW+UBoeBZtxJjKpH1Cn9pP6oaK10XqALrRHhH3U0dwl3W4wMozbte/
         Wg5l4OEE+u+elNkPMXEV43Ng13OkilIWAX/80PRvaVUTz6Nxc99bA19tRJH24Gqn84
         IpOlK+lWfKSoFETdY8I38mLSgWSyA7pwnRAG/9kOStrVU8lQol+glDxNIcmlOBs+Qn
         k+t1mqp2K2KTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 549B6C4316B;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <34c6ec4d-84f9-4009-96a5-98e5d3ff6dba@paulmck-laptop>
References: <34c6ec4d-84f9-4009-96a5-98e5d3ff6dba@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <34c6ec4d-84f9-4009-96a5-98e5d3ff6dba@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.10.28a
X-PR-Tracked-Commit-Id: 1566bf4b13daa66e3de6fdbc77ee3995df5a9064
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6750f0de53b7d64a4deffa62944ea431a153ec48
Message-Id: <169873095434.17204.11925020617250045436.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 05:42:34 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joel@joelfernandes.or
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:24:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.10.28a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6750f0de53b7d64a4deffa62944ea431a153ec48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
