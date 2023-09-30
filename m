Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73057B4271
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjI3RCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjI3RCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21686DD;
        Sat, 30 Sep 2023 10:02:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDC19C433C7;
        Sat, 30 Sep 2023 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093335;
        bh=3S6mq/Lq6gQreE/goEEQIkt0RB/YHVxq55dC7jm4yEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W96v4R6slLMXtffdwFO4wgtBXVbyKBC1EHKlXsVKRRRyJmtdSx41NJa+sJ7iS9VsS
         97NOpKThH210s9dmVGb1kq/ZDMtikrMsv8V5pfVYG01DZgjNp1sHDHC1HVXIecmbvo
         MyMKRss6nncVhHSwTVIuqOF6z5Bieq9PbxQfYjKP8Kn3nglrS/mUTMrFMoOkNzL0BJ
         hQteM4czkZmx+4o2xOG5wsVkMPnZzcnlAbdaXHtIKbCy3S34Rz3jNOXXnUCF62KH+W
         dufTBBCY9PDpNHFkcZPzV/VbjLuFpD263URVge9v+v2OcVBctEpOw4RauIHHEUxYcS
         HH9z8w8aNVtvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD1D2C43170;
        Sat, 30 Sep 2023 17:02:15 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv+=bHF+Q1fge0yU21nBkrP+4T089nuS_PE+cJZAXoE9g@mail.gmail.com>
References: <CAH2r5mv+=bHF+Q1fge0yU21nBkrP+4T089nuS_PE+cJZAXoE9g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv+=bHF+Q1fge0yU21nBkrP+4T089nuS_PE+cJZAXoE9g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc3-smb3-client-fix
X-PR-Tracked-Commit-Id: e6e43b8aa7cd3c3af686caf0c2e11819a886d705
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba77f7a63f4e4d4ffa5ad8c6665a104822992538
Message-Id: <169609333570.18163.5572406384609136155.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 17:02:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 10:33:34 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc3-smb3-client-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba77f7a63f4e4d4ffa5ad8c6665a104822992538

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
