Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2627DC675
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjJaGWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjJaGWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1EA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:22:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DD26C4E663;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698730954;
        bh=UFGRZKdKei48rUyLjqNLfILboxE29WoWDr0KF9PNKNU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lIC3d2ogVifaLwowsTghexlCQW7SFziYOgygyL6wp2VPA+sEnUpl85ra574leJ44K
         kxKUJfiQVy/AV9gPhXT6Xr9b+kz+Lm/MA0gs61ixZm7Rbsxl8pjYgfQvZjVvVXfRQJ
         le/KFMEhzahFI6EXeHeHwgjyYVzLQ0Vq6wPT60/QFcbNsaAHDaWhU3JBIN6wY/c41/
         oUuN3mTjcJQGQwc0ZTCnadkWxgNS0veapnaX6AStXkbDdAsDmF3xKKYA57PfmdpNsV
         ZOEiM/Em267lmyNK2FWeHhEc2mDDB4qkD66M4CmVc7/OkR4JhK53W/7mx3AwVlY9/F
         7SdoWc8cPxkVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C031C4316B;
        Tue, 31 Oct 2023 05:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <823dcba7-e078-4ad7-b2af-dabce9c4f325@paulmck-laptop>
References: <823dcba7-e078-4ad7-b2af-dabce9c4f325@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <823dcba7-e078-4ad7-b2af-dabce9c4f325@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.10.23a
X-PR-Tracked-Commit-Id: b8c60e8fc6f755c2cdf7164931afdbfa670c6646
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9049984f0e470af865c497c7f785fe895e5da9c
Message-Id: <169873095417.17204.4129744527571634028.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 05:42:34 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@lwt.eu, ammarfaizi2@gnuweeb.org,
        linux@weissschuh.net
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:21:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.10.23a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9049984f0e470af865c497c7f785fe895e5da9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
