Return-Path: <linux-kernel+bounces-5532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DA818BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A851F2534F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073111D130;
	Tue, 19 Dec 2023 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiKanF4P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437071D529;
	Tue, 19 Dec 2023 16:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18136C433C7;
	Tue, 19 Dec 2023 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001940;
	bh=mtSnw5oq09KGFtm0Le0UV134fhzHZdTO85S6QkPJg58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uiKanF4PYVj8h6CgzoX6L0pBnVb5EATGCFcANIGSvZpVx8WA1VMY9YLkvjhc6YCx1
	 +inbLAT2RKzKzBr+6ZGPaE3joLt3qyZo+3RzlXb0yeNMm5vEgUjpGYw2aIH1L4K9h9
	 ba/+dMGYz0PZ95iKYNzkKTCTe7kmwNg2V6JM58sdLcSP9b1jiwOGswuK9o8hVXXEHA
	 XY6V5kWKTtLl7UbC7+Kqz1ybLappf4U6KJ7y7mhSJvBHAxSSkrBcIc89BNQuTh2gOG
	 Z7Vmt7P+aXPUmR3FQsZBEwgy46XW36pJbhrty257JxPSz/6cuVGs8wQ5fHspVFTe1G
	 EfaYr5lpH+T8g==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, 
 Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Marian Postevca <posteuca@mutex.one>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218143214.939885-1-himanshu.bhavani@siliconsignals.io>
References: <20231218143214.939885-1-himanshu.bhavani@siliconsignals.io>
Subject: Re: [PATCH] ASoC: amd: acp: Remove redundant ret variable
Message-Id: <170300193880.59057.13762108753484482699.b4-ty@kernel.org>
Date: Tue, 19 Dec 2023 16:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 18 Dec 2023 20:02:08 +0530, Himanshu Bhavani wrote:
> Removed Unneeded variable: "ret"
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Remove redundant ret variable
      commit: 8b69dba103650b8247a336945c5fedc64ab5ddea

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


