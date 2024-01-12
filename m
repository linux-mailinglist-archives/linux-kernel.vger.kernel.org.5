Return-Path: <linux-kernel+bounces-25070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2582C72C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED9EB23F10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E918637;
	Fri, 12 Jan 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYOiOPYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B3182D5;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC182C43394;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098027;
	bh=dK9lHqW65SKOIgcEEJm8YgaIIEvB1iFuRSTdplS8+Zo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dYOiOPYSuoitnlR80/VXI3G7GS0OjUOLhwK5r9mu/bH45nA42+rAxd/HVIFue0eDp
	 JyTHsaIlHJYdJyr/FRkJB4oHAP2D1nJpaP2Db5hKh9VbnbnG4Tm4efY5k3ar4E8wpN
	 nFmL66jm4R9qJqw2afQALBIkNwyOPKicaYPKkA+EW4hkPUpjgwF9gqUe+ZPRmjs1tf
	 rf++pQROnZAaZUYRZHL8W5TcoZXibz/QMOPFyURlmC4FISkCTN+B8estRhZPOp9P3M
	 CZBQxgvJ5ZoFLKX+ypSD2jrXXJRy7nId/dhJopJTdiqyJUwKIQHbN5/Qz+/GW4M5LS
	 LUmCfyzFkf7Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9143D8C96D;
	Fri, 12 Jan 2024 22:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108172408.2220642-1-linux@roeck-us.net>
References: <20240108172408.2220642-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108172408.2220642-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8
X-PR-Tracked-Commit-Id: 41c71105a845ec1458680f01644d032a5fbbe0d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfec3cf3efbd897d774e3b5c08c2f0deaf9b5ad
Message-Id: <170509802768.4331.17318241622772667619.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:27 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 09:24:08 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfec3cf3efbd897d774e3b5c08c2f0deaf9b5ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

