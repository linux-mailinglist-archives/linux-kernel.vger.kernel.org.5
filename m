Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA87DFDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbjKCBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348002AbjKCBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6C19E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5A7DC433CA;
        Fri,  3 Nov 2023 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973225;
        bh=AnWclLcQuKd/X1RFJGjWgdJKtRLPwF5P6gATuDT3Pj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UDxctzxIki0QhhFObwLxIw1J+iRXLbyvUlg2OY0FxHECvoBVoOE7ivQYb5o9zBEAs
         Qz4/r3FQSjhCkJXu4No3IKGz+y2JkGKj0a4ersgiyRaBhNu0rU5rWyNEHgDI3GlwXT
         eUv2xH1bceeeQMuWFX9htQ6FPpTQOk9ZV0JNnR9UVerAS/p5BrgS5grNAfkboWp1NA
         +29RMf2sSv/C4qiRtMPM5VyA1M6OqlYyq38/eow6xRAF9jIwyY8ECUmWkLaWYBrp7J
         EL5HCZZM/poib+pE/PeUB2TBXUMRW1yy2DDThPO+Bn55XmeL0K2128dTkaCUSimIfk
         W1lYHPrVQTEag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1705EAB08B;
        Fri,  3 Nov 2023 01:00:25 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2311010039000.3534@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2311010039000.3534@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2311010039000.3534@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023110101
X-PR-Tracked-Commit-Id: 1372e73a18139d4f74731cc900085a6bf3c59daf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3
Message-Id: <169897322578.13409.15684410414503183053.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:25 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 00:43:29 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023110101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
