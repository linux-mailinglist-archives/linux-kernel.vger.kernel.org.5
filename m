Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D167D72C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5013123
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:00:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B155C433C8;
        Wed, 25 Oct 2023 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698256843;
        bh=2nERPDJJo/iFzCwUHAQJssuuyAKf3mzyWrOcRv5x2lw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rg/t6UCm0wsCBaSVfeYB+JFeSNlShBCKDDmAOi/8bg9IxLf5MJ7LfQxcWhCS2ZX/H
         KqpCd22j8ZuddxXzDV++tjr0Nr7/sU+O+KkGAZeLLl7fgshtq0hy7mK6uOuPXrkCYn
         cNUhlCwQZmWUGCifoxU0p4WMskjE72RPHR+PiGiCEo85zpp7kvMWA0y/INBck1UgdF
         jbx1TGVcV32GIC6rgUTyKWQZWjTTNuZrCigAK9G/TP3fJBWECm3fG4bXS01SqaGO0P
         F3YKotVG9qwGl4MsZp3oyEloc+w5gWls2DEfPODmRyrbHqGOn5A8PeNQMp/pfKEHyy
         94/nmjtNSMaew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37389E4CC0F;
        Wed, 25 Oct 2023 18:00:43 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.6-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hQGLq6JdJqVnhF_-DqXTjHubrt7khJi_ZoDU0diNTPMQ@mail.gmail.com>
References: <CAJZ5v0hQGLq6JdJqVnhF_-DqXTjHubrt7khJi_ZoDU0diNTPMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hQGLq6JdJqVnhF_-DqXTjHubrt7khJi_ZoDU0diNTPMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc8
X-PR-Tracked-Commit-Id: 9b311b7313d6c104dd4a2d43ab54536dce07f960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 611da07b89fdd53f140d7b33013f255bf0ed8f34
Message-Id: <169825684321.26933.16361374132237868253.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Oct 2023 18:00:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nvdimm@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 Oct 2023 19:51:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/611da07b89fdd53f140d7b33013f255bf0ed8f34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
