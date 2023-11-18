Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986F97F03A0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKRXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjKRXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF6194;
        Sat, 18 Nov 2023 15:35:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DC31C433C8;
        Sat, 18 Nov 2023 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700350507;
        bh=d8dOHKWXgHJrPE9rdJ31lYjRneEtnZd10jjBLEr4Bkg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GXfhbbhMDvrT8lc1Huz7/0hj5Y/VvRZDozi6dJfhwOwi1HDfoaHPaqRnPAY7YhbUe
         lHS66EozJdDldufhlL44Ppai2UOiz6UpyAV0w/GQA9S/OLAy34adboFLwL88rzXfsS
         HKJRmyO9FEk8MFAxX2NkcJMV53K1M+504Kf7irxS0TaZmq80lNNrRZr+ypRy7qkJW4
         h2Lbrv8bMV7Noh62cWziFfUDs10HBVBTpAY3QQPi2r8XL5faQEyRiHDxxzkxmNq1qH
         d+J6VikDAv1DQdF+m4P1i+ZkPVjVqcxao9sC1O2IZuqj27Xsc0o6YDfY1zzo5zQhGP
         1qeXv18E2wDdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BA22EA6303;
        Sat, 18 Nov 2023 23:35:07 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <040ce44df0bf702e4968a903d9ed06b82907a235.camel@HansenPartnership.com>
References: <040ce44df0bf702e4968a903d9ed06b82907a235.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <040ce44df0bf702e4968a903d9ed06b82907a235.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 2a0508d9d08f0c3e354044d4f48466ee0d225041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 037266a5f7239ead1530266f7d7af153d2a867fa
Message-Id: <170035050750.24051.5205364847492596543.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 23:35:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Nov 2023 17:38:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/037266a5f7239ead1530266f7d7af153d2a867fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
