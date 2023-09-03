Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F424790DAE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbjICTWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbjICTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1394
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD0BFB80B78
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 894BCC433C7;
        Sun,  3 Sep 2023 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693768953;
        bh=K3HDUzIIVA0hF+pHI86YXjjRnU3dHOZDiBACSgdSNPs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I22ZeCj2deBSh3Wj2ltict2RaED3b+u5afZ4ADtqWQp2qBln0EQMNrLeWXIqPWaWq
         jWmMt15Z3CR2fKHC3OWKBT3+GWcnKM6ideM3Wkny1x6UWuNEV02SKY4ZJLAhXnEk4B
         XHO5DVLITXY0eovHkuoSQp4qaPlyF5sUYmgJVRgelR3Onvd1My17QPUMR5dWLr5tPa
         SS66527/4oDZfHYnlX8JQQYY5yYB8Cd6vZeYQSPRx2ukCZ8NVpHJLIjhV2ypgNA2pF
         xIZzTkdnf5XldnAm/aTryjt2eC2n4CijUPdO2VRjEIUccEM3t2N/GQ7mkTr0pBfVBj
         yo9flws6wbKkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54076C64457;
        Sun,  3 Sep 2023 19:22:33 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire subsystem updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPS/vF/gX+sohJis@matsya>
References: <ZPS/vF/gX+sohJis@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPS/vF/gX+sohJis@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-rc1
X-PR-Tracked-Commit-Id: 8c4c9a9ae5aff2125ea44f0b26f9e3701d56d6db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e32dfcccfcc58e46c484357ee060d42d8481df8
Message-Id: <169376895306.10760.9801567412952627553.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Sep 2023 19:22:33 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Sun, 3 Sep 2023 22:47:48 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e32dfcccfcc58e46c484357ee060d42d8481df8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
