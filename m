Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D67C9A04
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJOQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjJOQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:24:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947AA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA05C433C8;
        Sun, 15 Oct 2023 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697387059;
        bh=8f63CAYHxOyikBRDn8akU9kedgvalA/IKL0Ho+o41rc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BGtYcLiMjxfVcouo+H15PuX0f475+FDz7Ztt0t/O5gHAmxCW1aEf1aQpgIoAEkYMz
         3D3Ao0QqCtDMGJ8I/6yzUOcpPLiEQheSTYWePrWAOX5vdwXCCSVMtExkAoCKhZfsxC
         TmIs//O0AqAl4KtP+sSFLI66coXDehpOfbfsIqydo5HprUebjs05F9S/VeRFs5kztx
         cv+AzklJjf0FuTAaGMSIZiKit/tN4Bw/8A+S5Nz7Mn0DVllVXH7gNjsJuTHhvI173U
         SX8gC+stFSP0Djsg2cbRljmsDKtgoODU705v7Libd2u9p/kwg8yZDbLb9cBeczFHGR
         k11QxkiFw+Gjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA671C39563;
        Sun, 15 Oct 2023 16:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSwEwMBjyYyiT9Tz@kroah.com>
References: <ZSwEwMBjyYyiT9Tz@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSwEwMBjyYyiT9Tz@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc6
X-PR-Tracked-Commit-Id: c9ca8de2eb15f9da24113e652980c61f95a47530
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11d3f72613957cba0783938a1ceddffe7dbbf5a1
Message-Id: <169738705982.6658.10473164280196112900.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 16:24:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Oct 2023 17:26:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11d3f72613957cba0783938a1ceddffe7dbbf5a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
