Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3097D4409
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJXAaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJXAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:30:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A591732
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22B2DC433CA;
        Tue, 24 Oct 2023 00:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698107374;
        bh=7fmhd8DIC99V62COMeNjeZ/2FwfO6Cl/+W9ccJ/wtCM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qx2pi4Ti7+U6lnGEc0zsMP5sz6XXUjJoZrNXehm1CAR/cbB/WNmRf3m8GSh4VOIvd
         Q5DdVE53G5UhHLpFOTnpBK17/rkss+ZhEUzqFnM7GCPe5JNYYcQzJnMDOI98PEJuN7
         JQpFm8jF35f87cHI1N36DyKuP5IkFGqlzL89p5O/RsKQvPo+pb4ATODnQl8IdMskGu
         JnsnjCdne7CpdavkSrCWQwfGyyKdXxjGfy2CnAEm1d0hIF55tvEToFhafxv8GUPY71
         +kjfesuObmK/LWD+4TPaxuA8lfcoGJu//4dvYWuwowrByXXrpywKQxuy2+6B/0hhSV
         VEVnLTX0LItVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C87CE4CC13;
        Tue, 24 Oct 2023 00:29:34 +0000 (UTC)
Subject: Re: [GIT PULL] urgent nolibc changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7a47c501-667a-499a-8c11-8039538d18ab@paulmck-laptop>
References: <7a47c501-667a-499a-8c11-8039538d18ab@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7a47c501-667a-499a-8c11-8039538d18ab@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent/nolibc.2023.10.16a
X-PR-Tracked-Commit-Id: 921992229b1f06df6b649860e4a5f3def1489866
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84186fcb834ecc55604efaf383e17e6b5e9baa50
Message-Id: <169810737404.11350.3862617903810803566.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Oct 2023 00:29:34 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@lwt.eu, linux@weissschuh.net,
        ammarfaizi2@gnuweeb.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 Oct 2023 16:16:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent/nolibc.2023.10.16a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84186fcb834ecc55604efaf383e17e6b5e9baa50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
