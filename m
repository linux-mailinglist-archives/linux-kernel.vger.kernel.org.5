Return-Path: <linux-kernel+bounces-18381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A4825C40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D2B23770
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E200B35F0E;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2xcmSPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD222EF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB4CC433C8;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491427;
	bh=p/B1O0r+YQ/Z4tDjcQ/pjutR7YcnXY2qajqhdidShBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2xcmSPrev3wbMlmCgsV3kdDTWpxEqMrIO/B+OngbVUz91q8n0SYkhBgCPLgnMh7D
	 9G0i2CavIniixCUbEm/p4C8ZSL37FId9ZHgCQ4RB/vUMtaz6ojMI+adUWOEZaIhvvt
	 LkLkWNYfp6JjLcYwlIyuiKIljAz9NI+oVI3eVXt8vlhxZGypWOI/hqXFWAxacMtXKG
	 XZV9NZduRUEc30V8N7dPJVCxvgTGA3BdTQSbtzzJ3iL9aT+EDaCA3k8Kj6U8GzqtBF
	 E52lTD/07jg0dQpySQQkuJdPXW3OeQH9+Jq0Uq4BLYb8jsiTNklRmhsP3oLAp59v1E
	 BXDO+4K1iq47Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A701BDCB6F7;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove obsolete rv32_defconfig file
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170449142768.26226.3943147801325806226.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 21:50:27 +0000
References: <20231121225320.3430550-1-samuel.holland@sifive.com>
In-Reply-To: <20231121225320.3430550-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, raven@themaw.net, paul.walmsley@sifive.com,
 svenjoac@gmx.de, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 21 Nov 2023 14:53:18 -0800 you wrote:
> This file is not used since commit 72f045d19f25 ("riscv: Fixup
> difference with defconfig"), where it was replaced by the
> 32-bit.config fragment. Delete the old file to avoid any confusion.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> [...]

Here is the summary with links:
  - riscv: Remove obsolete rv32_defconfig file
    https://git.kernel.org/riscv/c/f4727fe60ff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



