Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117227BB09C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjJFDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJFDuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:50:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD60EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:50:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F4F0C433C8;
        Fri,  6 Oct 2023 03:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696564212;
        bh=DUgoDVlitctNnT1Zbc6jU8pyCe6trSiIlkEVCyDSA0g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jXkmrwiqspVit8C8yjCgzJRoEpSeB0BirP2RbQzUznUpGeBwidbOqOajCGWvH4eiD
         vfx3IzczirFkKqQaCzCLnWGtydAXAC5m/gqeEbbqGE3VYzJh1Legls/NZ7wd/tAA5v
         NNqP+7yqkdoLFWqqOYYU7UnWHfdrQs0YLeR+wCz5/wgBMV4p76LtQexHK5U9ZaE+D1
         lTt8tLD6Vu6BmRX4Iz3jDZjPVanhZvbS101FORyzcauC3L6RQ697xmRHFpdwX5G09z
         dDipeYgwCOlB5lUJxIB4nNSBLg7+LrrYY/ZHFv+VZrx1kzVtP2B5w1YR/oeuNgkdJ9
         IWqL8ZoDacEyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5884EE632D0;
        Fri,  6 Oct 2023 03:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2310052240320.3534@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2310052240320.3534@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2310052240320.3534@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023100502
X-PR-Tracked-Commit-Id: b009aa38a380becd98cc4e01c9b7626a11cb4905
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19fbf677b2530740d71d4fb64ab2de0dbdc31111
Message-Id: <169656421235.12830.17578131449969887004.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 03:50:12 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Oct 2023 22:41:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023100502

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19fbf677b2530740d71d4fb64ab2de0dbdc31111

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
