Return-Path: <linux-kernel+bounces-17187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE5824954
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BF01C222EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498982C681;
	Thu,  4 Jan 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIjYsi9R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C92C190
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EB0C433C8;
	Thu,  4 Jan 2024 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704398524;
	bh=1Qa/+ncgUZ+rut/b7y+zByxvN2GqhS49L6cba2rRJ5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VIjYsi9RzEJYh0fRgjT66qMDHuAkfTitnuakx7NHgwrhJTX5HvM82UuGMPMfVbekZ
	 q9YA7YuPcgLIybFcaLf7X7Bllfu24s8lW5ibv4pcQ0TW59Cm5nIl2GnaIAuXOPvDFF
	 BWknIocIm6LvHjpOSxR8/KGDwc1Ry5cUYrZbeTmtwqw9JICDbVrSA+JE4SUtI6TPGA
	 2aZUs1L5TgUTaEC1UmkG477Mjy46PYWCDSuTCyMmBMSJsbql+E9jeh9l/3/Y7if73o
	 QQqPHSOnRgDeNHb4BzPbq5Z+AF1XDiTwrUNanE/j7Md9kp4BtVTri0ZL1GI6e85wqO
	 sB9QVeYxT0rJw==
From: Mark Brown <broonie@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240104101315.521301-1-naresh.solanki@9elements.com>
References: <20240104101315.521301-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH] uapi: regulator: Fix typo
Message-Id: <170439852313.84986.8172356920133375322.b4-ty@kernel.org>
Date: Thu, 04 Jan 2024 20:02:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 04 Jan 2024 15:43:15 +0530, Naresh Solanki wrote:
> Fix minor typo.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] uapi: regulator: Fix typo
      commit: 51088e5cc241178ccd6db2dd6d161dc8df32057d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


