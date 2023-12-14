Return-Path: <linux-kernel+bounces-91-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC2813C08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FE72834F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E56E2DF;
	Thu, 14 Dec 2023 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIYy1O5Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE2282E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32485C433D9;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=5QyxmMYJ8M0Zhf0Pi2Lb8jlyb51z43Cw5tcc/uGcs/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SIYy1O5QlycEh9jO1PYYpHDXPMzcPayuNC7W1aVJ5G6fQus2U8ds+UL8DL4XbFxEx
	 +IC0VDRmmLdxyiAG851lGs/anVUG0+lEZtuzTAFcJxpE1l9DCuqqUXiY1q5LdVnsY4
	 R+DvwRTaIfYdptqjpn9nn+vHn+LlXIEtYpNAl6snJotLowE7oAaObhJFnr4U4Ce2AK
	 8NJlxh4dO6mTtX4dqkBDsgptnH6sxupq76uA0FL+haMovUlZUgic1Z4gJyX/8BpF1D
	 MnnwzOIEVLVtiRYpnV3LC+/6Q9o+B84Lt1GLbsLVMU50C04koyobq0wAxKCEBFk97v
	 4jEUOUl5QTIDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F53DDD4EFE;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: allocate new section if it's not new
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703206.30587.6882657417862323311.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:32 +0000
References: <20231204180428.925779-1-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Dec 2023 10:04:25 -0800 you wrote:
> If fsck can allocate a new zone, it'd be better to use that instead of
> allocating a new one.
> 
> And, it modifies kernel messages.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: allocate new section if it's not new
    https://git.kernel.org/jaegeuk/f2fs/c/15a76c8014f9
  - [f2fs-dev,2/4] f2fs: fix write pointers on zoned device after roll forward
    https://git.kernel.org/jaegeuk/f2fs/c/9dad4d964291
  - [f2fs-dev,3/4] f2fs: check write pointers when checkpoint=disable
    https://git.kernel.org/jaegeuk/f2fs/c/aca90eea8a90
  - [f2fs-dev,4/4] f2fs: let's finish or reset zones all the time
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



