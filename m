Return-Path: <linux-kernel+bounces-21434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82F828F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15602851C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488653FB33;
	Tue,  9 Jan 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up7yg1Bv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C53EA80;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF8CC433C7;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836414;
	bh=dUyKgySfwksXb9fJv3G3n9otVepksm6qS4reUPsVZCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Up7yg1BvW4KviWsozu7dh7OQlj88DV0Wykdu+IQRlxJHSv1+8pvli85efbgjKibSC
	 hRxSxYIdqOocwVoKoywSsoTu9NoGytNXDsvtLHdq2ErnKKEQSWgs+SgsHjWDYndyGS
	 v4Gtk3QE/cmBCY0GEof//Nt16kYpqWBOyHLMRCa3kBKeNHyDpO4HL8F38IUldGmJ9g
	 6uEllq8v8+/NRYY9JLqNQo+6NF8aqDRhFLcsmDH4jeMtiEHZGi0FmHNSYEPmdWZpkr
	 hImywnwE1BpHpsFnZETOTIkOqigldxBJ/w5Hm2kUrZ08CLyIXKSm1eluwwhTj9FQr8
	 5EqtMARvW5pyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49D2DD8C970;
	Tue,  9 Jan 2024 21:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <e4c5630fbd56ea57b51df50c4c7b0e865e89f4b6.camel@linux.ibm.com>
References: <e4c5630fbd56ea57b51df50c4c7b0e865e89f4b6.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e4c5630fbd56ea57b51df50c4c7b0e865e89f4b6.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8
X-PR-Tracked-Commit-Id: c00f94b3a5be428837868c0f2cdaa3fa5b4b1995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c1dd1fe5d8a1d43ed96e2e0ed44a88c73c5c039
Message-Id: <170483641429.1854.13211529511728064878.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:14 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 09 Jan 2024 08:41:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c1dd1fe5d8a1d43ed96e2e0ed44a88c73c5c039

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

