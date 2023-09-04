Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6D791D52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350967AbjIDSnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350389AbjIDSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32395CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA34B80EF8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D84C433D9;
        Mon,  4 Sep 2023 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693853021;
        bh=bI+YB52Xw74DRpIaQIe7SUhFxJoXxGzZRCttgmOOmMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mdw4hmlFjTh68eHLoRK0v6dczI4TDOthZuMX9/3F/5lDXQgZhdDdrOPm38zNh3WJW
         LHQpFUVpkDQ8lQtCGbJs4o7Cxc2YjHg0ZbMNbUzj7KXqB8SeX5SnOaWtyoPBYoT9Z3
         za+X3gSoIN/nwJsF0gaDWen3i5gI+RosPgJLcN4MXe12g3N2j29WqeWlJ2vR2XuK/L
         WI40nrb5TRJ/nVvq0Hf3a+Oh/RAuwnx5yt8c5IVLrWwHWZQQA6mgffeHln26seBEGN
         AFqSOK35Jdc3Pf78RFOOlYN4CDwwwq8EqBqsU8lQHUXyk1+F7P0nDaMAzhFQWRkAiJ
         3SlmriiqMaY4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F109C04DD9;
        Mon,  4 Sep 2023 18:43:41 +0000 (UTC)
Subject: Re: [GIT PULL] UML Changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
References: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1189803925.12843.1693768434048.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1
X-PR-Tracked-Commit-Id: 974b808d85abbc03c3914af63d60d5816aabf2ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68d76d4e7e506664ffb7b28805469ed73044368f
Message-Id: <169385302138.15626.673868116805116131.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 18:43:41 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 21:13:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68d76d4e7e506664ffb7b28805469ed73044368f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
