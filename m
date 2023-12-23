Return-Path: <linux-kernel+bounces-10578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6DE81D673
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A9E282CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB6171BE;
	Sat, 23 Dec 2023 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCaG/Vbe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAA15E97;
	Sat, 23 Dec 2023 20:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8729C433C8;
	Sat, 23 Dec 2023 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703362870;
	bh=JNGRVnMa3662bEfrFLkBnNgJ8uGBrUoPyKUTcegWbcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RCaG/VbeA/r8zMI8tt9yaMO81fJMzUi1DtrhdmdlYCQRAQAhzzMa9cSjWUag6m0C3
	 QOsKbTbTDgnYwnhgbUEJ8Oudc44hJ+6+OF/sNDo9HPheT6R4uAYz/lUCjwQK92O8zs
	 hjIKxYionrPOufMvTdyS+A/9CX4F8ohFVuWwf0WfgGp3ujKBJl/05gKe2EFjqionNh
	 K+fUEQX0VcTRYOe01eG70gw/UZOBXmHmcyGyRERRgOgoPu1u19hOYEFM2VUbE6G9AK
	 L79XkKCXsNgon6UNgZJKjDMfQXa5DxZ+8Qmx45Pnls8sOtHjtGODys1sjs8TQ0AZV0
	 y8o5bRwzJI9dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5CCBC561EE;
	Sat, 23 Dec 2023 20:21:10 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYaqHUkBTsBP0_ZQ@kroah.com>
References: <ZYaqHUkBTsBP0_ZQ@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYaqHUkBTsBP0_ZQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc7
X-PR-Tracked-Commit-Id: ab241a0ab5abd70036c3d959146e534a02447d17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b2ee6d2b33d56e36da552a26e817eeed637e76e
Message-Id: <170336287080.28590.1826296808985196062.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 20:21:10 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Dec 2023 10:36:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b2ee6d2b33d56e36da552a26e817eeed637e76e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

