Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99E680B671
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjLIVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjLIVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:11:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361C10E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 13:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E21C433C7;
        Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702156277;
        bh=h8buZ2IBiA++XSGduzIdIJoihRJx+y2kdU3W2P8GguI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YDBaI345UQg4np3jvtgPJxE/AazUEEYWzDeQD15OVAnecCnY0QxhSXfmthJOi5Yj6
         S19m/8v5GMAgzh30F8iamQ0oVQspa32POivNhRXWuWnZm3vfTJRoTXKpeQZ0p0qoo4
         0+cuiE6TmNhkZflho1JhIGuE7EKCg8kyzSAXaazeD9j+bALItkztEILnqmsk7lGw2B
         7ReVwW3q2FuQdHGCuHdX3owWPsPG1TUCDrNxhAN/6kGLzcOEZbmMBuynClWOhx0uzw
         mm0CLnpU5xaQsN1PYeq+ToDZmhffudWstM+45JFr0jvpZLGzKuOHsGcdqqxod4VOuo
         FbzNU7ZXfxS0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1100BC04DD9;
        Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXRxx0o07FDnsRhN@kroah.com>
References: <ZXRxx0o07FDnsRhN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXRxx0o07FDnsRhN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc5
X-PR-Tracked-Commit-Id: 61890dc28f7d9e9aac8a9471302613824c22fae4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21b73ffcc62ab772bc06e3e90bd87eff5e9e8ed4
Message-Id: <170215627706.20711.15799502446513904618.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 21:11:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Dec 2023 14:55:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21b73ffcc62ab772bc06e3e90bd87eff5e9e8ed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
