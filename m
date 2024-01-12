Return-Path: <linux-kernel+bounces-24304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09982BAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898B5B22A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F255B5C7;
	Fri, 12 Jan 2024 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0nRd7pP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C325C8E1;
	Fri, 12 Jan 2024 05:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64004C433F1;
	Fri, 12 Jan 2024 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036063;
	bh=FjVAvZkT5xwfaZbsR+XrFkdT+0BZaPoGtHhrchhMdlk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B0nRd7pP0xT+hNFpPbPNGmwGKBtWbZsVmUt6UfcQonnuVu5Kf+iuBOX/yGjuPaT7w
	 4HYmQRSHaTUPjPsllumjDOtTQkY6PF02fHaLEl0OSr6djKpbg5n6NGjiTjZnRy4v1Y
	 qkXjNRmE4AQorB8Yljit93WofWEW6OqxtUVZMYLBR6uQ3i2mKs/YD4XYDZccdIWt+c
	 t4pePZAlJ1slc4xVqPHfxL8uUjXS1JfXEEC+om4evP/iHf1eLjb51jLQH8JaUYVPn1
	 HiS2C+BOdm1TyHMDiPUF/HgUxczKz41JE8Yaoby14+xmfov9u6XxJdvi1QlC6dq+80
	 9iw9Ph6dUq0ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52B79DFC697;
	Fri, 12 Jan 2024 05:07:43 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvajaHtTgnfMYd2BQ+w9XoBvN7tcjaG17W-Zb9r0KDG_w@mail.gmail.com>
References: <CAH2r5mvajaHtTgnfMYd2BQ+w9XoBvN7tcjaG17W-Zb9r0KDG_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvajaHtTgnfMYd2BQ+w9XoBvN7tcjaG17W-Zb9r0KDG_w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes
X-PR-Tracked-Commit-Id: 8fb7b723924cc9306bc161f45496497aec733904
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a31658aa1c0b757df652f6fcf3a001f90fda302
Message-Id: <170503606333.7299.14885274231206110612.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:43 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 08:20:59 -0600:

> git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a31658aa1c0b757df652f6fcf3a001f90fda302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

