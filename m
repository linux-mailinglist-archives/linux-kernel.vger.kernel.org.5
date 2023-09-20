Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089937A8CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjITTcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjITTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:32:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191131B0;
        Wed, 20 Sep 2023 12:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F034C433AB;
        Wed, 20 Sep 2023 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695238304;
        bh=PslVLVAWLGRCunjlPT6cdEldzcdIiPvjsu/BqQzPdHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u4nDbS9T9fhpeDNvvuMKJ9Ci4JhTA9URMVkcJg40jrdmLWMW/B/obPiWR1N5/hw/a
         d7BJMt1pvg5cuWSctagdGUte4minIZYgctWYjjuTjU9BNSc1a0XLW/pl1ucDGkhcfi
         KcxZzk8u2l/NSehu+3VZPANVs/6PwUbYJVQ5xywgaV42Lbi45xaWD+KXNffkZ6c71r
         WQP1ya8wSXsHpP0rJ6WaR6t0OQbVMOjsSR9xTqhdKipAWfMoUNOhZNWyBKYy0nD/v6
         kn2nKI437cK4BNtMSv9caCehJGmCkIql/3Zpr2N27ZqKVWy2TTaS0zBp1q1xm9LYXW
         RzopOAKPBhaqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C8FC40C5E;
        Wed, 20 Sep 2023 19:31:44 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6-rc3] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230920200902.72ee092c@sal.lan>
References: <20230920200902.72ee092c@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230920200902.72ee092c@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-2
X-PR-Tracked-Commit-Id: 263cb0cc5abac7c22a6c0dfa7e50e89d8e6c6900
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42dc814987c1feb6410904e58cfd4c36c4146150
Message-Id: <169523830408.24049.1227797317999208199.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Sep 2023 19:31:44 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Sep 2023 20:09:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42dc814987c1feb6410904e58cfd4c36c4146150

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
