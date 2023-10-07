Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969CA7BC987
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbjJGSMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjJGSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:12:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEABC;
        Sat,  7 Oct 2023 11:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0E0CC433CC;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702354;
        bh=mBNt6TabayTYrRPVHjDo8tyq8+aucpDb0waD6CEkedE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hC9Q3MilI/2ftzhi1ThKeKbEk22D6CEePSS8XSnwOtLrKVuZNwg+CeEA/grMNl23V
         sGOpakYJZ8rPpGErhSvlfprScOj9C3NJ/rG541iN7l2qX4WvKD9OwEmO0+1vjyiJ7H
         3vEGBjmEWqCS9Vl6xMx+MBjmdQ966xDdvhLVed/0DVYPky2cHiqLSPgyVBooqyS1Wj
         lj9I4fpK2UCBXY2vl66n/qLrJGXd2SpR7YcSUmAWixJvMr6RNbKia1U/2LjnC6tqmA
         L047yetT7t2OcxL7+dmjTIZfbB6SkJD3CFK1WyQ+WIq027uBgoOKd8F1PrAcaVoQYN
         HknZe3tRqfVwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFABCC41671;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv0jM=ydHxYsw8zNNAMcUAt30pdtc=s-X-nfDo2pdtZNA@mail.gmail.com>
References: <CAH2r5mv0jM=ydHxYsw8zNNAMcUAt30pdtc=s-X-nfDo2pdtZNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv0jM=ydHxYsw8zNNAMcUAt30pdtc=s-X-nfDo2pdtZNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc4-smb3-client-fixes
X-PR-Tracked-Commit-Id: 3b8bb3171571f92eda863e5f78b063604c61f72a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59f3fd30af355dc893e6df9ccb43ace0b9033faa
Message-Id: <169670235484.17695.5061762203455830393.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:34 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 16:44:57 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc4-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59f3fd30af355dc893e6df9ccb43ace0b9033faa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
