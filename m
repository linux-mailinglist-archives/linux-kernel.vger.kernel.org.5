Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9517F3781
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKUUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjKUUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:33:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCAF1BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F83EC433C7;
        Tue, 21 Nov 2023 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700598830;
        bh=1991og8E1e5l/9/O4vSl7yzRyCLWLnKwc/dM9uElRYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mysl36pOZSeJYr6oAPAJ3TxclsdCgrKNKpKaqFG+9Ukw381WdWLzKQ+aG/nsJo8Un
         CQ7wthoMJPo+5+j8CU6HhS3jg8EazL2MTHjZx74uylFWE9sOnllwuxA2Sn1nv1a78y
         8wZd0DfZ9bD5ZMgW1kdTgLEAsd9CIrXCp2S40qV7E85gqQtT/s7OT0s/EG7SR324UM
         SBESnzkF87rW5bQHrFrsEDyL71UxcUn8kORon8zur+Wbdi+/SdtM5ma5BmjmyHq1/a
         ZAXVhp1eG/7nfyb67Snw+b7TIyqYsJdkg1JX2p5RB3iqW3GNWyZUNR7nt36fTPvkHX
         en9HrZU4Lf4QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0371EAA95B;
        Tue, 21 Nov 2023 20:33:49 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdf76a$dogiv@smtpauth.intel.com>
References: <cdf76a$dogiv@smtpauth.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdf76a$dogiv@smtpauth.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-2
X-PR-Tracked-Commit-Id: a6584711e64d9d12ab79a450ec3628fd35e4f476
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2d5304e6c648ebcf653bace7e51e0e6742e46c8
Message-Id: <170059882997.5512.18383713125026376097.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Nov 2023 20:33:49 +0000
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Nov 2023 10:56:09 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2d5304e6c648ebcf653bace7e51e0e6742e46c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
